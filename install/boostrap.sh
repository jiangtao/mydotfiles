#!/bin/bash

# jiangtao's shell for initing on macosx

# create usual dirs

echo "making dirs..."

mkdir ~/places
mkdir ~/places/work
mkdir ~/places/personal


if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# modify brew mirror to http://mirrors.ustc.edu.cn/
cd "$(brew --repo)" && git remote set-url origin https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-core.git
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

brew update

# install tools
tools=(
  ripgrep 
  git 
  vim 
  autojump 
  tree
  nginx
  wget
  gifsicle # gif tools for unix
  mkcert # mkcert for localhost 
  bat # cat with line number
  fd # better find command
  timothyye/tap/ydict # youdao dict
  jq
  koekeishiya/formulae/skhd
  koekeishiya/formulae/yabai
  thefuck # fuck the wrong spell
)

brew install ${tools[@]}

# Install nvm and node

echo "Installing nvm..."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install stable
nvm alias default stable

# Install common Node Global Modules
# https://stackoverflow.com/questions/1335815/how-to-slice-an-array-in-bash  bash copy array

modules=(
#   webpack
  yarn
  gulp
  tldr
  project-next-cli
  tree
  tig
)

echo "installing node modules..."
npm i -g ${modules[@]}

# oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# add suggestion plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# add zsh plugins
echo "plugins=(git zsh-autosuggestions)" >> $HOME/.zshrc

# clone files and conf some lns

git clone https://github.com/jiangtao/mydotfiles.git ~/places/personal/mydotfiles

ln -sf ~/places/personal/mydotfiles/ln/.gitignore_global ~/.gitignore_global 
ln -sf ~/places/personal/mydotfiles/ln/.tmux.conf ~/.tmux.conf 
ln -sf ~/places/personal/mydotfiles/ln/.zshrc ~/.zshrc 
ln -sf ~/places/personal/mydotfiles/ln/.npmrc ~/.npmrc
ln -sf ~/places/personal/mydotfiles/ln/.yarnrc ~/.yarnrc 
ln -sf ~/places/personal/mydotfiles/ln/.npmrc ~/.skhdrc
ln -sf ~/places/personal/mydotfiles/ln/.yarnrc ~/.yabairc

tmux source-file ~/.tmux.conf

# configure rust env

if test ! $(which rustup); then
  echo "Initing Rust Env..."
  ruby -e "$(curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh)"
  echo source $HOME/.cargo/env >> ~/.zshrc
fi

source $HOME/.cargo/env

# configure vim 

# bash vim.sh

# Install Brew Cask
echo "Installing brew cask..."

# Apps
# https://caskroom.github.io/search
apps=(
#   google-chrome-canary
  firefox
  helm
#  shadowsocksx
#   youdaonote
  clash  # instead of shadowsocks
  aText
  
  ## dev tools
  sourcetree
  imageoptim
  beyond-compare
  
  upic # 通用图床配置
  
  # webstorm
  # vmware-fusion
  
  ## my tools
  qqmusic
  kindle
#   wewechat
  foxmail
  omnigraffle
  # HandBrake # compress video and audio 
)

# Install apps to /Applications

echo "installing apps..."
# latest brew use option cask install app
brew install --cask --appdir="/Applications" ${apps[@]} 

echo "Done."


