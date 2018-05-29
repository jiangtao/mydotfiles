#!/bin/bash

# jiangtao's shell for initing on macosx

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
  tldr
  project-next-cli
  tree
)

echo "installing node modules..."
npm i -g ${modules[@]}

# oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# add suggestion plugin
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

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
ln -sf ~/places/personal/mydotfiles/ln/.yarnrc ~/.yarnrc 

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
  youdaonote
  
  ## dev tools
  sourcetree
  imageoptim
  beyond-compare
  
  # webstorm
  # vmware-fusion
  
  ## my tools
  qqmusic
  kindle
  wewechat
  foxmail
  omnigraffle
)

# Install apps to /Applications

echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Done."


