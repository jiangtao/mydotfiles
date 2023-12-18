# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM=xterm-256color


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export SSLKEYLOGFILE=~/tls/sslkeylog.log

# android sdk config
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools

# mongo
# alias bsondump='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/bsondump'
# alias mongo='/usr/local/Cellar/mongodb-community/4.4.0/bin/mongo'
# alias mongod='/usr/local/Cellar/mongodb-community/4.4.0/bin/mongod'
# alias mongodump='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongodump'
# alias mongoexport='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongoexport'
# alias mongofiles='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongofiles'
# alias mongoimport='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongoimport'
# alias mongooplog='/usr/local/etc/mongodb/bin/mongooplog'
# alias mongoperf='/usr/local/etc/mongodb/bin/mongoperf'
# alias mongorestore='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongorestore'
# alias mongos='/usr/local/Cellar/mongodb-community/4.4.0/bin/mongos'
# alias mongosniff='/usr/local/etc/mongodb/bin/mongosniff'
# alias mongostat='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongostat'
# alias mongotop='/usr/local/Cellar/mongodb-database-tools/100.1.1/bin/mongotop'

# wrk
alias wrk="$HOME/places/open/wrk2/wrk"

# mysql
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
# npm
alias rmnm="find . -name 'node_modules'  | xargs -I {} rm -fr  {}"
alias sourcetree="open -a Sourcetree"
# set yarn taobao 
alias 2cyarn="yarn config set registry https://registry.npm.taobao.org"
alias 2yarn="yarn config delete registry"
alias ggfetch="git stash save local && git fetch && git rebase origin master"
alias gitc="git commit -m"
alias gitsc="git commit -S -m"

# chrome headless
alias chrome="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias dfe="bash $HOME/places/work/shell/fe.deploy.sh"
alias server="python -m SimpleHTTPServer"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TERM=xterm-256color
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:/usr/local/bin:$HOME/bin
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

alias w_dev="./node_modules/.bin/cross-env NODE_ENV=development DEPLOY=dev yarn build && scp -r  dist pa.hexyun:/mnt/wuwei"
alias w_test="yarn run deploy:test && scp -r  dist pa.hexyun:/mnt/wuwei/pre"
alias w_prod="yarn run deploy:prod && scp -r  dist pa.hexyun:/mnt/wuwei/production"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PATH="/usr/local/opt/openssl/bin:$PATH"
eval 
            fuck () {
                TF_PYTHONIOENCODING=$PYTHONIOENCODING;
                export TF_SHELL=zsh;
                export TF_ALIAS=fuck;
                TF_SHELL_ALIASES=$(alias);
                export TF_SHELL_ALIASES;
                TF_HISTORY="$(fc -ln -10)";
                export TF_HISTORY;
                export PYTHONIOENCODING=utf-8;
                TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
                ) && eval $TF_CMD;
                unset TF_HISTORY;
                export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
                test -n "$TF_CMD" && print -s $TF_CMD
            }
        
alias python=/usr/local/bin/python3
alias editor_dev="scp -r  dist/index.html dist/static   wuwei:/mnt/editor-front"
alias wuwei_dev="scp -r dist/* wuwei:/mnt/wuwei-front/"
alias editor_prod="scp -r  dist/index.html dist/static   wuwei-prod:/mnt/editor-front"
alias wuwei_prod="scp -r dist/* wuwei-prod:/mnt/wuwei-front/"
plugins=(git zsh-autosuggestions)

alias mnpm="npm --registry=http://r.npm.sankuai.com \
--cache=$HOME/.cache/mnpm \
--disturl=http://npm.sankuai.com/mirrors/node \
--userconfig=$HOME/.mnpmrc"
alias ws="open -a WebStorm"
alias st="open -a Sourcetree"
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color 
alias gc="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias ynpm="yarn config set registry https://registry.npm.taobao.org"
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"
alias cht="curl cht.sh/"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export LDFLAGS=-L/usr/local/opt/tcl-tk/lib
export CPPFLAGS=-I/usr/local/opt/tcl-tk/include
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export LDFLAGS=-L/usr/local/opt/python@3.8/lib
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH=$PATH:/usr/local/mysql/bin

export PNPM_HOME="/Users/jth/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# fnm
export PATH=/Users/jth/.fnm:$PATH
eval "`fnm env`"
export GPG_TTY=$(tty)

export GO111MODULE=on
function ll {
  cd "$(llama "$@")"
}
export EDITOR=vim
# Please run the shell with root user, ignore it in zsh config
yabai --load-sa

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

fnm use ~/.node-version