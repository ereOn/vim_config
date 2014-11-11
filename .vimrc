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
Plugin 'Shougo/unite.vim'

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

" Reload configuration upon save.
au BufWritePost $MYVIMRC :source $MYVIMRC

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
set encoding=utf8
set termencoding=utf-8
set fileencodings=utf8

" Show line numbers.
set number

" Starts GVim maximized.
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

" Ignore some files.
set wildignore=*.swp,*.bak,*.pyc,*.class

" History.
set history=1000
set undolevels=1000

" Map unite.
noremap <C-p> :Unite file<cr>
