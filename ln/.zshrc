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

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
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
alias bsondump='/usr/local/Cellar/mongodb/3.6.5/bin/bsondump'
alias mongo='/usr/local/Cellar/mongodb/3.6.5/bin/mongo'
alias mongod='/usr/local/Cellar/mongodb/3.6.5/bin/mongod'
alias mongodump='/usr/local/Cellar/mongodb/3.6.5/bin/mongodump'
alias mongoexport='/usr/local/Cellar/mongodb/3.6.5/bin/mongoexport'
alias mongofiles='/usr/local/Cellar/mongodb/3.6.5/bin/mongofiles'
alias mongoimport='/usr/local/Cellar/mongodb/3.6.5/bin/mongoimport'
alias mongooplog='/usr/local/Cellar/mongodb/3.6.5/bin/mongooplog'
alias mongoperf='/usr/local/Cellar/mongodb/3.6.5/bin/mongoperf'
alias mongorestore='/usr/local/Cellar/mongodb/3.6.5/bin/mongorestore'
alias mongos='/usr/local/Cellar/mongodb/3.6.5/bin/mongos'
alias mongosniff='/usr/local/Cellar/mongodb/3.6.5/bin/mongosniff'
alias mongostat='/usr/local/Cellar/mongodb/3.6.5/bin/mongostat'
alias mongotop='/usr/local/Cellar/mongodb/3.6.5/bin/mongotop'

# wrk
alias wrk="$HOME/places/open/wrk2/wrk"

# mysql
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# npm
alias cnpm="npm --registry=https://registry.npm.taobao.org"
alias rmnm="find . -name 'node_modules'  | xargs -I {} rm -fr  {}"
alias sourcetree="open -a Sourcetree"
# set yarn taobao 
alias 2cyarn="yarn config set registry https://registry.npm.taobao.org"
alias 2yarn="yarn config delete registry"

# chrome headless
alias chrome="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias dfe="bash $HOME/places/work/shell/fe.deploy.sh"
alias server="python -m SimpleHTTPServer"
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
plugins=(git zsh-autosuggestions)
export TERM=xterm-256color
export TERM=xterm-256color
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
