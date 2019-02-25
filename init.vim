"
" Neovim configuration.
"

" Set <Leader> to ",".
let mapleader=","

" Python environments.
let g:python3_host_prog=$PYTHON3
let g:python_host_prog=$PYTHON2

" Enable mouse support.
"
" This is necessary for clipboard-pasting to work on Windows.
set mouse=a

" vim-plug plugins.
call plug#begin()

" Themes.
Plug 'chriskempson/base16-vim'

" Status bar.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" FuzzySearch.
Plug 'ctrlpvim/ctrlp.vim'

" Git integration
Plug 'Tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Whitespace/trailing whitespaces handling.
Plug 'Ntpeters/vim-better-whitespace'

" Undo history and branching.
Plug 'Sjl/gundo.vim'

" Go.
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'Shougo/deoplete.nvim', has('nvim') ? {} : {'on': []}
Plug 'zchee/deoplete-go', has('nvim') ? {'do': 'make'} : {'on': []}
Plug 'nsf/gocode', {'rtp': 'vim'}
Plug 'sebdah/vim-delve', has('nvim') ? {} : {'on': []}

" Asynchronous Linter
Plug 'w0rp/ale', v:version >= 800 ? {} : {'on': []}

" Python formatter
Plug 'google/yapf'

" Python completion
Plug 'python-mode/python-mode'

" Terraform
Plug 'hashivim/vim-terraform'

" Perforce
Plug 'nfvs/vim-perforce'

call plug#end()

" Backups.
if has("unix")
    set backupdir^=/tmp
    set directory^=/tmp//,.
    set undodir^=~/.vim/undo,/tmp//,.
elseif has('win32') || has ('win64') || has("win32unix")
    let s:temp_vim_dir = $TEMP . "/vim"
    if finddir(s:temp_vim_dir, &rtp) ==# ''
        call mkdir(s:temp_vim_dir)
    endif

    let s:backup_dir = $TEMP . "/vim/backup"
    if finddir(s:backup_dir, &rtp) ==# ''
        call mkdir(s:backup_dir)
    endif
    execute "set backupdir^=".s:backup_dir."//"

    let s:undo_dir = $HOME . "/vimfiles/undo"
    if finddir(s:undo_dir, &rtp) ==# ''
        call mkdir(s:undo_dir)
    endif
    execute "set undodir^=".s:undo_dir."//"

    let s:swap_dir = $TEMP . "/vim/swap"
    if finddir(s:swap_dir, &rtp) ==# ''
        call mkdir(s:swap_dir)
    endif
    execute "set directory^=".s:swap_dir."//"
endif

" Theme.
colorscheme base16-default-dark
set background=dark
let g:airline_theme='base16'

" Set the encoding.
set encoding=utf8
set termencoding=utf8
set fileencodings=utf8

" Show line numbers.
set number

" Ignore some files.
set wildignore=*.swp,*.bak,*.pyc,*.class

" Completion options.
set completeopt=longest,menu

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1

" Remap Ctrl+C and Ctrl+X to copy/cut via XMing
vmap <C-C> "*y
vmap <C-X> "*c

" History.
set history=1000

" Persistent undo.
set undofile
set undolevels=1000
set undoreload=10000

" I want to highlight my searches.
set hlsearch
set showmatch

" I want to be able to delete using the backspace key.
set backspace=indent,start

" I don't want distractions.
set guioptions=
set showtabline=2
set noshowmode

" Make 10 lines visible around the current cursor position.
set scrolloff=10

" UNIX line endings by default.
set fileformats=unix,dos
set fileformat=unix

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

" Fixes an issue with the quickfix windows with Go.
let g:go_list_type = "quickfix"

" Go bindings.
augroup gosyntax
	au!
	au BufRead,BufNewFile go.template setfiletype go
	au FileType go set shiftwidth=4
	au FileType go set tabstop=4
	au FileType go set softtabstop=4
	au FileType go set noexpandtab
	au FileType go nmap <leader>r <Plug>(go-run)
	au FileType go nmap <leader>b <Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-coverage)
	au FileType go nmap <Leader>ds <Plug>(go-def-split)
	au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
	au FileType go nmap <Leader>dt <Plug>(go-def-tab)
	au FileType go nmap <Leader>gd <Plug>(go-doc)
	au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
	au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
	au FileType go nmap <Leader>gi <Plug>(go-import)
	au FileType go nmap <Leader>gr <Plug>(go-rename)
	au FileType go nmap <c-I> :GoDecls<cr>
	au FileType go nmap <c-O> :GoDeclsDir<cr>

	" Close quickfix and jump back to previous buffer. Useful after running
	" the tests.
	au FileType go nmap <c-Y> :ccl<cr>:bd<cr>
augroup end

" Recognize SConscript and SConstruct files as Python.
augroup sconsfiletypes
	au!
	au BufRead,BufNewFile SConscript setfiletype python
	au BufRead,BufNewFile SConstruct setfiletype python
augroup end

" Syntax for C++
augroup cppsyntax
	au!
	aut FileType c,cpp,cpp11 set tabstop=4
	aut FileType c,cpp,cpp11 set shiftwidth=4
	aut FileType c,cpp,cpp11 set expandtab
augroup end

" Syntax for vim files
augroup vimsyntax
	au!
	au FileType vim set tabstop=4
	au FileType vim set shiftwidth=4
	au FileType vim set expandtab
augroup end

" Syntax for cmake files
augroup cmakesyntax
	au!
	au FileType cmake set tabstop=4
	au FileType cmake set shiftwidth=4
	au FileType cmake set expandtab
augroup end

" Syntax for rST files
augroup rstsyntax
	au!
	au FileType rst set tabstop=3
	au FileType rst set shiftwidth=3
	au FileType rst set expandtab
augroup end

" Syntax for yaml files
augroup yamlsyntax
    au!
	au BufRead,BufNewFile yaml.template setfiletype yaml
	au FileType yaml set tabstop=2
	au FileType yaml set shiftwidth=2
	au FileType yaml set expandtab
augroup end

" Syntax for LUA files
augroup luasyntax
	au!
	au FileType lua set tabstop=4
	au FileType lua set shiftwidth=4
	au FileType lua set expandtab
augroup end

" Syntax for HTML files
augroup htmlsyntax
	au!
	au FileType html set tabstop=2
	au FileType html set shiftwidth=2
	au FileType html set expandtab
augroup end

" Syntax for Javascript files
augroup javascriptsyntax
	au!
	au FileType javascript set tabstop=2
	au FileType javascript set shiftwidth=2
	au FileType javascript set expandtab
augroup end

" Manage Go imports upon save and format.
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 0

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable ALE integration with airline.
let g:airline#extensions#ale#enabled = 1

" Disable Rope for Python.
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
