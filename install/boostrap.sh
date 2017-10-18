#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# install tools
tools=(
  ripgrep 
  git 
  vim 
  autojump 
  tree
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
  webpack
  yarn
  gulp
  eslint
  eslint-plugin-vue
  eslint-config-standard
  eslint-plugin-import
  eslint-plugin-node
  chef-cli
#   phantomjs
#   gtop
)

echo "installing node modules..."
npm install -g ${modules[@]}

# oh my zsh 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# create usual dirs

echo "making dirs..."
mkdir ~/places/work
mkdir ~/places/personal

# clone files and conf some lns

git clone https://github.com/jiangtao/mydotfiles.git ~/places/personal/mydotfiles

ln -sf ~/places/personal/mydotfiles/ln/.gitignore_global ~/.gitignore_global 
ln -sf ~/places/personal/mydotfiles/ln/.tmux.conf ~/.tmux.conf 
ln -sf ~/places/personal/mydotfiles/ln/.zshrc ~/.zshrc 
ln -sf ~/places/personal/mydotfiles/ln/.npmrc ~/.npmrc 

tmux source-file ~/.tmux.conf

# configure vim 

bash vim.sh

# Install Brew Cask
echo "Installing brew cask..."
brew install caskroom/cask/brew-cask

# Apps
# https://caskroom.github.io/search
apps=(
  google-chrome-canary
  firefox
  helm
  shadowsocksx
  # dev tools
  vmware-fusion
  sourcetree
  imageoptim
  webstorm
  # my tools
  qqmusic
  kindle
  wewechat
)

# Install apps to /Applications

echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Done."

