#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# install tools
brew install ripgrep git vim autojump

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
  phantomjs
  gtop
  eslint
  eslint-plugin-vue
  eslint-config-standard
  eslint-plugin-import
  eslint-plugin-node
)

echo "installing node modules..."
npm install -g ${modules[@]}

# Install Brew Cask
echo "Installing brew cask..."
brew install caskroom/cask/brew-cask

# Apps
# https://caskroom.github.io/search
apps=(
  google-chrome-canary
  firefox
  divvy
  visual-studio-code
)

# Install apps to /Applications

echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# create usual dirs

echo "making dirs..."
mkdir ~/Places/Work
mkdir ~/Places/Person

echo "Done."


