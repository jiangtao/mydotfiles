#!/bin/bash

# jiangtao's shell for initing on macosx

# keep the brew which was installed successfully

# brew update

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
  jq
  koekeishiya/formulae/skhd
  koekeishiya/formulae/yabai
  thefuck # fuck the wrong spell
)

brew install ${tools[@]}

# Install nvm and node

echo "Installing fnm..."
brew install fnm
echo 18.16.1 >> $HOME/.node-version
source $HOME/.zshrc

modules=(
#   webpack
  yarn
  pnpm
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

# add suggestion plugin y5
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# add zsh plugins
echo "plugins=(git zsh-autosuggestions)" >> $HOME/.zshrc

# clone files and conf some lns

git clone https://github.com/jiangtao/mydotfiles.git ~/places/personal/mydotfiles

ln -sf ~/places/personal/mydotfiles/ln/.gitignore_global ~/.gitignore_global 
ln -sf ~/places/personal/mydotfiles/ln/.zshrc ~/.zshrc 
ln -sf ~/places/personal/mydotfiles/ln/.npmrc ~/.npmrc
ln -sf ~/places/personal/mydotfiles/ln/.yarnrc ~/.yarnrc 
ln -sf ~/places/personal/mydotfiles/ln/.skhdrc ~/.skhdrc
ln -sf ~/places/personal/mydotfiles/ln/.yabairc ~/.yabairc


# 启动 skhd
skhd --start-service

# 启动yabai

# ln -sf ~/places/personal/mydotfiles/ln/.tmux.conf ~/.tmux.conf 

# tmux source-file ~/.tmux.conf

# configure rust env

if test ! $(which rustup); then
  echo "Initing Rust Env..."
  /bin/bash -c "$(curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh)"
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
  aText
  sourcetree
  imageoptim
  beyond-compare
  drawio
  kap
)

# Install apps to /Applications

echo "installing apps..."
# latest brew use option cask install app
brew install --cask --appdir="/Applications" ${apps[@]} 

echo "Done."


