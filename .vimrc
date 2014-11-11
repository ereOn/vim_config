"
" My Vim configuration.
"

" Necessary for Vundle to operate properly.
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize.
if has("win32") || has("win16")
	set rtp+=~/vimfiles/bundle/Vundle.vim/
	call vundle#begin('~/vimfiles/bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

call vundle#end()
filetype plugin indent on

" Disable backups.
set nobackup