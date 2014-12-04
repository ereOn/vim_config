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

" For a nice statusbar
Plugin 'bling/vim-airline'

" Some themes
Plugin 'Altercation/vim-colors-solarized'
Plugin 'vim-scripts/darktango.vim'
Plugin 'baskerville/bubblegum'
Plugin 'chriskempson/base16-vim'

" FuzzySearch
Plugin 'kien/ctrlp.vim'

" Git integration
Plugin 'Tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Easy commenting with 'gc'.
Plugin 'Tpope/vim-commentary'

" Easy surrounding change with 'cs'.
Plugin 'Tpope/vim-surround'

" Execute tasks in background.
Plugin 'Tpope/vim-dispatch'

" Nosetests integration.
Plugin 'okcompute/vim-nose'

" Tags bar.
Plugin 'majutsushi/tagbar'

" Syntax linters.
Plugin 'scrooloose/syntastic'

" Need by xolox's plugins.
Plugin 'xolox/vim-misc'

" Enable fullscreen, maximize.
Plugin 'xolox/vim-shell'

" Update tags by deleting entries.
Plugin 'vim-scripts/AutoTag'

" Python pep8 syntax.
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Hdima/python-syntax'

" Better completion.
Plugin 'vim-scripts/ucompleteme'

" Better session management.
Plugin 'Manuel-colmenero/vim-simple-session'

" Add a motion "ii" to select lines that have the same indentation level.
Plugin 'Michaeljsmith/vim-indent-object'

" Whitespace/trailing whitespaces handling.
Plugin 'Ntpeters/vim-better-whitespace'

" Undo history and branching.
Plugin 'Sjl/gundo.vim'

" Use "gS" to split a one-liner; use "gJ" to join several lines.
Plugin 'AndrewRadev/splitjoin.vim'

call vundle#end()
filetype plugin indent on

" Set the leader key to ,.
let mapleader=","
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
call ucompleteme#Setup()

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

" Color the 80th column for Python.
autocmd FileType python set colorcolumn=80

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
	\ 'file': '\v(\.exe|\.so|\.dll|\.pdb|\.sln|\.suo|tags|\.vcproj|\.txt|\.jpg|\.jpeg|\.gif|\.png|\.bpt|\.tlog|\.pdf|\.pyc)$',
\ }
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
	\ }
\ }
let g:ctrlp_max_height = 20
" No limits on files
let g:ctrlp_max_files = 0
" Unlimited depth
let g:ctrlp_max_depth = 100

" See all tags with Ctrl-O.
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
let g:easytags_dynamic_files=2

function! b:generate_repo_tags()
	let l:repo = fugitive#repo()
	let l:repo_files = split(system(l:repo.git_command('ls-files', '-oc', '--exclude-standard'), '[^\r\n]*'), '\n')
	call xolox#easytags#update(0, 0, l:repo_files)
endfunction

function! g:set_tags_file()
	try
		let l:repo = fugitive#repo()
		let l:root_dir = fnamemodify(l:repo.git_dir, ":h")
		let l:tags_file = l:root_dir.".tags"
		command! -b GenerateTags call b:generate_repo_tags()
	catch
		if has("win32") || has("win16")
			let l:tags_file = "~/_vimtags"
		else
			let l:tags_file = "~/.vimtags"
		endif
	endtry

	execute ':setlocal tags='.l:tags_file
endfunction

" augroup settags
" 	au!
" 	au BufEnter,BufRead * :call g:set_tags_file()
" augroup end

" Remove fullscreen notice on startup.
let g:shell_fullscreen_message=0
let g:shell_fullscreen_always_on_top=0

" Disable saving some things into the sessions.
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

" Fold Python files upon opening.
augroup pythonfolding
	au!
	autocmd FileType python setlocal foldmethod=syntax
	autocmd FileType python setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
augroup end
