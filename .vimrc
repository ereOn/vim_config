"
" My Vim configuration.
"

" Necessary for Vundle to operate properly.
set nocompatible
filetype off

" Set the leader to ","
let mapleader=","

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
Plugin 'Altercation/vim-colors-solarized'
Plugin 'vim-scripts/darktango.vim'
Plugin 'baskerville/bubblegum'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Tpope/vim-fugitive'
Plugin 'Tpope/vim-commentary'
Plugin 'Tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-shell'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'davidhalter/jedi-vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Derekwyatt/vim-fswitch'
Plugin 'Hdima/python-syntax'
Plugin 'Manuel-colmenero/vim-simple-session'
Plugin 'Michaeljsmith/vim-indent-object'
Plugin 'Ntpeters/vim-better-whitespace'
Plugin 'Sjl/gundo.vim'
Plugin 'AndrewRadev/splitjoin.vim'

call vundle#end()
filetype plugin indent on

" Disable backups.
set nobackup

" Always display the statusbar.
set laststatus=2

" Set the colorscheme.
colorscheme base16-default
set background=dark
let g:airline_theme='base16'

" Set the font.
set guifont=Anonymice_Powerline:h13
set antialias
let g:airline_powerline_fonts=0

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
		au GUIEnter * Fullscreen
	else
	endif
endif

" Map keys to TagBar.
map <C-Left> :TagbarClose<cr>
map <C-Right> :TagbarOpenAutoClose<cr>

" Folds by default.
set foldlevelstart=1
set foldopen=block,insert,mark,percent,quickfix,search,tag,undo

" CtrlP settings.
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_extensions = ['tag', 'buffertag', 'session']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(\.git)$',
  \ 'file': '\v(\.exe|\.so|\.dll|\.pdb|\.sln|\.suo|tags|\.vcproj|\.txt|\.jpg|\.jpeg|\.gif|\.png|\.bpt|\.tlog|\.pdf|\.pyc)$',
  \ 'link': '',
  \ }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_max_height = 20
" No limits on files
let g:ctrlp_max_files = 0
" Unlimited depth
let g:ctrlp_max_depth = 100
map <C-O> :CtrlPBufTagAll<cr>

" UNIX line endings by default.
set fileformats=unix,dos
set fileformat=unix

" Syntastic.
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E124,E265'
let g:syntastic_haskell_ghc_mod_args='-g -fno-warn-type-defaults'

" Tell easytags to operate in the background.
let g:easytags_async=1
let g:easytags_events = ['BufWritePost']

" Configure tags per project.
au BufRead * exec "setlocal tags=../".fnamemodify(substitute(system("cd ".expand("%:h")." & git rev-parse --show-toplevel"), '\n$', '', ''), ":t").".tags"
au BufRead * exec ":UpdateTags -R ".substitute(system("cd ".expand("%:h")." & git rev-parse --show-toplevel"), '\n$', '', '')
let g:easytags_dynamic_files=2

" Remove fullscreen notice on startup.
let g:shell_fullscreen_message=0
let g:shell_fullscreen_always_on_top=0

" Disable the help preview for Python files.
autocmd FileType python setlocal completeopt-=preview

" Disable saving some things into the sessions.
set sessionoptions-=options,winpos
