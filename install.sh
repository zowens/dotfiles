#!/bin/sh

echo "Installing links..."
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vim/vimrc $HOME/.vimrc

echo "Installing vundle..."
git clone git@github.com:gmarik/Vundle.vim.git $PWD/vim/bundle/Vundle.vim 1> /dev/null

echo "Installing plugins..."
vim +PluginInstall +qall

echo "Installing YCM..."
(cd vim/bundle/YouCompleteMe && ./install.sh --clang-completer)

echo "Installing Vimproc..."
(cd vim/bundle/vimproc && make)
