#!/bin/bash

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
source_dir="$repo_root/codex"
codex_dir="${CODEX_HOME:-$HOME/.codex}"
config_file="$codex_dir/config.toml"
timestamp="$(date +%Y%m%d-%H%M%S)"
backup_dir="$codex_dir/backups/mydotfiles-$timestamp"

top_begin="# >>> mydotfiles: codex shared top >>>"
top_end="# <<< mydotfiles: codex shared top <<<"
tables_begin="# >>> mydotfiles: codex shared tables >>>"
tables_end="# <<< mydotfiles: codex shared tables <<<"

usage() {
  echo "Usage: $0 {preview|install|apply|check}"
}

codex_binary() {
  if command -v codex >/dev/null 2>&1; then
    command -v codex
  elif [ -x "/Applications/ChatGPT.app/Contents/Resources/codex" ]; then
    echo "/Applications/ChatGPT.app/Contents/Resources/codex"
  else
    return 1
  fi
}

require_sources() {
  for path in \
    "$source_dir/AGENTS.md" \
    "$source_dir/agents" \
    "$source_dir/instructions" \
    "$source_dir/config.shared.toml.tmpl" \
    "$source_dir/disabled-skills.txt"
  do
    if [ ! -e "$path" ]; then
      echo "Missing source: $path" >&2
      exit 1
    fi
  done
}

render_shared_top() {
  awk '/^# __MYDOTFILES_TABLES__$/ {exit} {print}' "$source_dir/config.shared.toml.tmpl"
}

render_shared_tables() {
  awk 'found {print} /^# __MYDOTFILES_TABLES__$/ {found=1}' "$source_dir/config.shared.toml.tmpl"

  while IFS= read -r skill_path || [ -n "$skill_path" ]; do
    case "$skill_path" in
      ""|"#"*) continue ;;
    esac

    if [ ! -e "$HOME/$skill_path" ]; then
      continue
    fi

    echo
    echo "[[skills.config]]"
    printf 'path = "%s/%s"\n' "$HOME" "$skill_path"
    echo "enabled = false"
  done < "$source_dir/disabled-skills.txt"
}

split_local_config() {
  local input_file="$1"
  local local_top_file="$2"
  local local_tables_file="$3"

  awk -v top_file="$local_top_file" -v tables_file="$local_tables_file" \
    -v top_begin="$top_begin" -v top_end="$top_end" \
    -v tables_begin="$tables_begin" -v tables_end="$tables_end" '
    function is_managed_header(line) {
      return line == "[features.multi_agent_v2]" ||
        line == "[agents]" ||
        line == "[mcp_servers]" ||
        line == "[mcp_servers.tempad-dev]" ||
        line == "[plugins.\"documents@openai-primary-runtime\"]" ||
        line == "[plugins.\"pdf@openai-primary-runtime\"]" ||
        line == "[plugins.\"spreadsheets@openai-primary-runtime\"]" ||
        line == "[plugins.\"presentations@openai-primary-runtime\"]" ||
        line == "[plugins.\"template-creator@openai-primary-runtime\"]" ||
        line == "[plugins.\"visualize@openai-bundled\"]" ||
        line == "[plugins.\"codex-app-tools@openai-bundled\"]" ||
        line == "[plugins.\"sites@openai-bundled\"]" ||
        line == "[plugins.\"sites@openai-curated-remote\"]" ||
        line == "[plugins.\"deep-research-work@openai-curated-remote\"]" ||
        line == "[plugins.\"plugin-management@openai-curated-remote\"]" ||
        line == "[plugins.\"openai-templates@openai-curated-remote\"]" ||
        line == "[plugins.\"browser@openai-bundled\"]" ||
        line == "[plugins.\"unified-computer-use@openai-bundled\"]" ||
        line == "[plugins.\"chrome@openai-bundled\"]" ||
        line == "[plugins.\"computer-use@openai-bundled\"]" ||
        line == "[features]" ||
        line == "[[skills.config]]"
    }

    function is_managed_top(line) {
      return line ~ /^(model|model_reasoning_effort|supports_websockets)[[:space:]]*=/
    }

    $0 == top_begin {
      in_managed_top = 1
      next
    }

    $0 == top_end {
      in_managed_top = 0
      next
    }

    in_managed_top {
      if ($0 ~ /^service_tier[[:space:]]*=/) {
        print > top_file
      }
      next
    }

    $0 == tables_begin {
      in_managed_tables = 1
      next
    }

    $0 == tables_end {
      in_managed_tables = 0
      next
    }

    in_managed_tables {
      next
    }

    /^\[.*\]$/ {
      saw_header = 1
      if (is_managed_header($0)) {
        skip_table = 1
        next
      }
      skip_table = 0
    }

    skip_table {
      next
    }

    saw_header == 0 && is_managed_top($0) {
      next
    }

    {
      if (saw_header) {
        print > tables_file
      } else {
        print > top_file
      }
    }
  ' "$input_file"
}

build_candidate() {
  local output_file="$1"
  local local_top_file="$2"
  local local_tables_file="$3"

  : > "$local_top_file"
  : > "$local_tables_file"

  if [ -f "$config_file" ]; then
    split_local_config "$config_file" "$local_top_file" "$local_tables_file"
  fi

  {
    echo "$top_begin"
    render_shared_top
    echo "$top_end"
    cat "$local_top_file"
    echo "$tables_begin"
    render_shared_tables
    echo "$tables_end"
    cat "$local_tables_file"
  } > "$output_file"
}

validate_candidate() {
  local candidate="$1"
  local codex_bin
  local validation_dir

  if ! codex_bin="$(codex_binary)"; then
    echo "Codex binary not found; cannot validate config." >&2
    exit 1
  fi

  validation_dir="$(mktemp -d "${TMPDIR:-/tmp}/mydotfiles-codex-validate.XXXXXX")"
  cp "$candidate" "$validation_dir/config.toml"

  if ! CODEX_HOME="$validation_dir" "$codex_bin" --strict-config --version >/dev/null; then
    find "$validation_dir" -depth -delete
    echo "Generated Codex config failed strict validation." >&2
    exit 1
  fi

  find "$validation_dir" -depth -delete
}

apply_config() {
  local candidate
  local local_top
  local local_tables

  mkdir -p "$codex_dir"
  candidate="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-config.XXXXXX")"
  local_top="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-top.XXXXXX")"
  local_tables="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-tables.XXXXXX")"

  build_candidate "$candidate" "$local_top" "$local_tables"
  validate_candidate "$candidate"

  if [ -f "$config_file" ] && cmp -s "$candidate" "$config_file"; then
    echo "Codex shared config is already up to date."
  else
    mkdir -p "$backup_dir"
    if [ -f "$config_file" ]; then
      cp "$config_file" "$backup_dir/config.toml"
    fi
    mv "$candidate" "$config_file"
    echo "Applied shared config to $config_file"
    echo "Backup directory: $backup_dir"
  fi

  rm -f "$candidate" "$local_top" "$local_tables"
}

link_item() {
  local source_path="$1"
  local target_path="$2"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    return
  fi

  mkdir -p "$backup_dir"
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    mv "$target_path" "$backup_dir/$(basename "$target_path")"
  fi

  ln -s "$source_path" "$target_path"
  echo "Linked $target_path -> $source_path"
}

install_links() {
  mkdir -p "$codex_dir"
  link_item "$source_dir/AGENTS.md" "$codex_dir/AGENTS.md"
  link_item "$source_dir/agents" "$codex_dir/agents"
  link_item "$source_dir/instructions" "$codex_dir/instructions"
}

check_links() {
  local failed=0

  for name in AGENTS.md agents instructions; do
    if [ ! -L "$codex_dir/$name" ] || [ "$(readlink "$codex_dir/$name")" != "$source_dir/$name" ]; then
      echo "Link mismatch: $codex_dir/$name" >&2
      failed=1
    fi
  done

  return "$failed"
}

check_config() {
  local candidate
  local local_top
  local local_tables
  local codex_bin

  candidate="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-check.XXXXXX")"
  local_top="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-check-top.XXXXXX")"
  local_tables="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-check-tables.XXXXXX")"
  build_candidate "$candidate" "$local_top" "$local_tables"

  if ! cmp -s "$candidate" "$config_file"; then
    rm -f "$candidate" "$local_top" "$local_tables"
    echo "Codex shared config is out of sync; run: $0 apply" >&2
    return 1
  fi

  rm -f "$candidate" "$local_top" "$local_tables"

  if ! codex_bin="$(codex_binary)"; then
    echo "Codex binary not found; cannot run strict config check." >&2
    return 1
  fi

  "$codex_bin" --strict-config --version >/dev/null
  echo "Codex links and shared config are in sync."
}

preview_links() {
  local name

  for name in AGENTS.md agents instructions; do
    if [ -L "$codex_dir/$name" ] && [ "$(readlink "$codex_dir/$name")" = "$source_dir/$name" ]; then
      echo "Link $name: already managed"
    elif [ -e "$codex_dir/$name" ] || [ -L "$codex_dir/$name" ]; then
      echo "Link $name: would replace after backup"
    else
      echo "Link $name: would create"
    fi
  done
}

preview_config() {
  local candidate
  local local_top
  local local_tables
  local skill_count

  candidate="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-preview.XXXXXX")"
  local_top="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-preview-top.XXXXXX")"
  local_tables="$(mktemp "${TMPDIR:-/tmp}/mydotfiles-codex-preview-tables.XXXXXX")"

  build_candidate "$candidate" "$local_top" "$local_tables"
  validate_candidate "$candidate"

  if [ -f "$config_file" ] && cmp -s "$candidate" "$config_file"; then
    echo "Config: already up to date"
  else
    echo "Config: would update after backup"
  fi

  skill_count="$(awk '/^\[\[skills\.config\]\]$/ {count++} END {print count + 0}' "$candidate")"
  echo "Strict config validation: passed"
  echo "Disabled Skill entries on this device: $skill_count"

  rm -f "$candidate" "$local_top" "$local_tables"
}

main() {
  local command="${1:-}"

  require_sources

  case "$command" in
    preview)
      preview_config
      preview_links
      echo "Preview only; no Codex files were changed."
      ;;
    install|apply)
      apply_config
      install_links
      check_links
      check_config
      echo "Restart Codex to load the updated configuration."
      ;;
    check)
      check_links
      check_config
      ;;
    *)
      usage
      exit 2
      ;;
  esac
}

main "$@"
