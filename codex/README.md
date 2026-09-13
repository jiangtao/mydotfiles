# Codex 系统优化方案（待 Review）

本目录只抽取本轮 Codex 系统优化的可移植结果。目前处于 Review 状态，不应直接 commit 或 push。

## 范围边界

只包含：

- 精简后的全局协作规则；
- 6 个边界明确的子 Agent 角色及分发、实施、验证和 Review 规则；
- 多 Agent、插件和 Skill 的共享开关策略；
- 将上述结果安装到另一台设备的脚本。

不读取、不复制、不托管任何项目代码或项目知识。尤其禁止写入任何雇主、客户或工作项目相关的名称、路径、配置、日志、文档、域名、项目 ID 或业务信息。

## Git 管理范围

- `AGENTS.md`：全局协作约定。
- `agents/`：个人子 Agent 角色。
- `instructions/`：按任务加载的详细规则。
- `config.shared.toml.tmpl`：跨设备共享的 Codex 配置。
- `disabled-skills.txt`：相对 `$HOME` 的禁用 Skill 策略；脚本只为当前设备上实际存在的 Skill 生成配置。当前 6 个 Agent 不依赖这些个人 Skill。

以下内容必须留在本机，禁止提交：`auth.json`、Session、日志、缓存、状态数据库、插件缓存、项目可信路径、应用版本路径、浏览器哈希和其他凭证或设备状态。安装脚本只在本机合并 `~/.codex/config.toml`，不会把其中的本地配置反向写入仓库。

共享模板只接管其中明确列出的顶层键，以及 `[agents]`、`[features]`、禁用 Skill、指定插件和 `tempad-dev` MCP；这些范围以仓库版本为准。其他本机配置保留在托管标记之外。方案不强制 `fast` 或 `priority` 服务层级，避免跨设备默认提高额度或 API 费用。

`e2e_tester` 保留为必要角色，默认使用当前设备已连接、具有任务所需登录态和 Profile 上下文的真实 Chrome；它不依赖个人 `browser-skill`。官方浏览器扩展需要在每台电脑、每个 Chrome Profile 中单独安装和连接，属于设备状态，不由 Git 同步；未连接、Profile 不匹配或登录态失效时测试应报告受阻，不自动安装，也不得用内置浏览器结果冒充真实 Chrome 验收。只有当前任务明确接受隔离环境时，内置浏览器才可作为有限验证方式。

## 审查未提交候选

先验证候选配置，不修改本机：

```bash
./install/codex.sh preview
```

确认 Review 范围仍只有两个新增路径：

```bash
git status --short -- codex install/codex.sh
```

如需在不 stage 的情况下查看完整新增内容：

```bash
for file in $(find codex -type f | sort) install/codex.sh; do
  git diff --no-index -- /dev/null "$file" || true
done
```

上述命令不修改 Git index。不要使用 `git add` 只是为了生成 Review diff。

## 安装到当前电脑

先执行只读预览：

```bash
./install/codex.sh preview
```

确认输出后再安装：

```bash
./install/codex.sh install
```

安装脚本会：

1. 将 `~/.codex/AGENTS.md`、`agents/`、`instructions/` 链接到本仓库；
2. 把共享配置合并进 `~/.codex/config.toml`；
3. 保留上述托管范围之外的设备专属配置；
4. 修改前备份原文件到 `~/.codex/backups/mydotfiles-<时间>/`；
5. 使用 Codex 严格配置检查验证结果。

完成后彻底退出并重新打开 Codex。

随后在每台设备上完成一次本机 Chrome 接入：在桌面应用的 `Settings > Computer Use` 中为目标 Chrome Profile 安装并连接官方扩展，确认界面显示 `Manage`，并保持 Chrome 开关可在 `@` 提及菜单中选择。扩展、Profile、登录态和站点授权不会由本仓库同步。

## Review 通过后的日常同步

在一台电脑修改规则或 Agent 文件后，它们会直接显示在本仓库的 Git diff 中：

```bash
git diff -- codex
git add codex install/codex.sh
git commit -m "chore: sync codex configuration"
git push
```

另一台电脑执行：

```bash
git pull --rebase
./install/codex.sh apply
./install/codex.sh check
```

共享配置以 `codex/config.shared.toml.tmpl` 为准。不要把整份 `~/.codex/config.toml` 复制回仓库；需要调整公共设置时编辑模板，然后运行 `apply`。

## 命令

- `preview`：生成并严格验证候选配置，只报告是否会更新配置或链接，不打印配置内容，也不修改 `$CODEX_HOME` 或仓库。
- `install`：首次安装，合并配置并建立符号链接。
- `apply`：应用仓库中的最新共享配置并修复链接。
- `check`：只读检查链接、配置同步状态和 TOML 语法。

脚本不会执行 Git commit 或 push。方案通过人工 Review 前，不提交这些文件。

## Review 检查项

- 主模型与 6 个 Agent 的模型、推理强度和职责是否符合预期；
- 73 个禁用 Skill 是否正确；
- 启用与禁用的插件、MCP 是否符合日常使用；
- 共享模板接管范围是否可以接受；
- Review 通过后，再决定是否 commit 和 push。
