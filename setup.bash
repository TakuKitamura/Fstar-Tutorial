#!/bin/bash

ln -s /root/fstar-tutorial/bin/fstarHelper.bash /usr/local/bin/fstarHelper
echo "call plug#begin()" >> ~/.vimrc
echo "Plug 'FStarLang/VimFStar', {'for': 'fstar'}" >> ~/.vimrc
echo "call plug#end()" >> ~/.vimrc
echo "source /root/fstar-tutorial/vim/fstarHelper.vim" >> ~/.vimrc
