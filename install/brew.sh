#!/bin/bash
echo "making dirs..."

mkdir ~/places
mkdir ~/places/work
mkdir ~/places/personal


if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# modify brew mirror to http://mirrors.ustc.edu.cn/
cd "$(brew --repo)" && git remote set-url origin https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-core.git
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
