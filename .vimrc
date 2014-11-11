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
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/darktango.vim'
Plugin 'baskerville/bubblegum'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" Disable backups.
set nobackup

" Always display the statusbar.
set laststatus=2

" Set the colorscheme.
colorscheme bubblegum

" Enable syntax highlighting.
syntax on

" Enhanced menu completion.
set wildmenu

" Add a ruler.
set ruler

" Indentation settings.
set autoindent
set copyindent
set shiftround

" Show the matching parenthesis.
set showmatch

" Better cursor.
"set cursorcolumn
"set cursorline

" Color the 80th column.
set colorcolumn=80

" Set the encoding.
set termencoding=utf-8
set fileencodings=utf8

" Show line numbers.
set number

" Ignore some files.
set wildignore=*.swp,*.bak,*.pyc,*.class

" History.
set history=1000
" Persistent undo.
set undofile
set undolevels=1000
set undodir=$HOME/vimfiles/undo
set undoreload=10000

" I want to highlight my searches.
set hlsearch
set showmatch

" I want to be able to delete using the backspace key.
set backspace=indent,start

" I don't want distractions.
set guioptions=

" Starts GVim maximized.
if has("gui_running")
	if has("win32") || has("win16")
		au GUIEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
		map <F11> <esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
	else
		set lines=999 columns=999
	endif
endif
