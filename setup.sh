#!/bin/sh

echo Copying init.vim for Neovim...
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

echo Installing vim-plug for Neovim...
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo Copying .vimrc for Vim...
cp init.vim ~/.vimrc

echo Installing vim-plug for Vim...
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
