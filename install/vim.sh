# 
# configure terminal color 

echo 'export TERM=xterm-256color' >> ~/.zshrc  # or ~/.zshrc if you use default bash

# configure vim 

git clone https://github.com/cherrot/vimrc.git ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -sf ~/.vim/.vimrc ~/

# after, do `vim`, :PluginInstall .
# read more: https://github.com/jiangtao/vimrc 