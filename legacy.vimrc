"
" My Vim configuration.
"

" Necessary for Vundle to operate properly.
set nocompatible
filetype off

" Set the leader to ","
let mapleader=","

" Set the runtime path to include Vundle and initialize.
if has("win32") || has("win16") || has("win32unix")
	set rtp+=~/vimfiles/bundle/Vundle.vim/
	call vundle#begin('~/vimfiles/bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

" For a nice statusbar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Some themes
Plugin 'Altercation/vim-colors-solarized'
Plugin 'vim-scripts/darktango.vim'
Plugin 'baskerville/bubblegum'
Plugin 'chriskempson/base16-vim'

" FuzzySearch
Plugin 'ctrlpvim/ctrlp.vim'

" Git integration
Plugin 'Tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Need by xolox's plugins.
Plugin 'xolox/vim-misc'

" Enable fullscreen, maximize.
Plugin 'xolox/vim-shell'

" Python pep8 syntax.
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Hdima/python-syntax'

" Integrate sessions in CtrlP
Plugin 'okcompute/vim-ctrlp-session'

" Add a motion "ii" to select lines that have the same indentation level.
Plugin 'Michaeljsmith/vim-indent-object'

" Whitespace/trailing whitespaces handling.
Plugin 'Ntpeters/vim-better-whitespace'

" Undo history and branching.
Plugin 'Sjl/gundo.vim'

" Python text objects
Plugin 'okcompute/vim-python-text-objects'

" Go
Plugin 'fatih/vim-go'

if has('nvim')
    Plugin 'sebdah/vim-delve'

    " Asynchronous Linter
    Plugin 'w0rp/ale'
endif

" gocode
Plugin 'nsf/gocode', {'rtp': 'vim/'}

" Completion for NeoVim
if has('nvim')
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'zchee/deoplete-go'
endif

call vundle#end()
filetype plugin indent on

" Set the leader key to ,.
let mapleader=","

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

" Always display the statusbar.
set laststatus=2

" Set the colorscheme.
colorscheme base16-default-dark
set background=dark
let g:airline_theme='base16'

" Set the font.
if !has("nvim")
    if has("gui_running")
        if has("win32") || has("win16") || has("win32unix")
            set guifont=DejaVuSansMono:h13
            set antialias
            let g:airline_powerline_fonts=0
        else
            set guifont=Monospace\ 15
            set antialias
            let g:airline_powerline_fonts=0
        endif
    endif
else
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
endif

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

" Recognize SConscript and SConstruct files as Python.
augroup sconsfiletypes
	au!
	autocmd BufRead,BufNewFile SConscript setfiletype python
	autocmd BufRead,BufNewFile SConstruct setfiletype python
augroup end

" Syntax for C++
augroup cppsyntax
	au!
	autocmd FileType c,cpp,cpp11 set tabstop=4
	autocmd FileType c,cpp,cpp11 set shiftwidth=4
	autocmd FileType c,cpp,cpp11 set expandtab
augroup end

" Syntax for vim files
augroup vimsyntax
	au!
	autocmd FileType vim set tabstop=4
	autocmd FileType vim set shiftwidth=4
	autocmd FileType vim set expandtab
augroup end

" Syntax for cmake files
augroup cmakesyntax
	au!
	autocmd FileType cmake set tabstop=4
	autocmd FileType cmake set shiftwidth=4
	autocmd FileType cmake set expandtab
augroup end

" Syntax for rST files
augroup rstsyntax
	au!
	autocmd FileType rst set tabstop=3
	autocmd FileType rst set shiftwidth=3
	autocmd FileType rst set expandtab
augroup end

" Syntax for yaml files
augroup yamlsyntax
	au!
	autocmd FileType yaml set tabstop=2
	autocmd FileType yaml set shiftwidth=2
	autocmd FileType yaml set expandtab
augroup end

" Syntax for LUA files
augroup luasyntax
	au!
	autocmd FileType lua set tabstop=4
	autocmd FileType lua set shiftwidth=4
	autocmd FileType lua set expandtab
augroup end

" Syntax for HTML files
augroup htmlsyntax
	au!
	autocmd FileType html set tabstop=2
	autocmd FileType html set shiftwidth=2
	autocmd FileType html set expandtab
augroup end

" Syntax for Javascript files
augroup javascriptsyntax
	au!
	autocmd FileType javascript set tabstop=2
	autocmd FileType javascript set shiftwidth=2
	autocmd FileType javascript set expandtab
augroup end

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
set undoreload=10000

" I want to highlight my searches.
set hlsearch
set showmatch

" I want to be able to delete using the backspace key.
set backspace=indent,start

" I don't want distractions.
set guioptions=
set showtabline=2

" Starts GVim maximized.
if !has("nvim")
    if has("gui_running")
        if has("win32") || has("win16") || has("win32unix")
            au GUIEnter * simalt ~n
            au GUIEnter * simalt ~x
        else
        endif
    endif
endif

" Map keys to TagBar.
map <C-Left> :TagbarClose<cr>
map <C-Right> :TagbarOpenAutoClose<cr>

" Folds by default.
set foldlevelstart=1
set foldopen=block,insert,mark,percent,quickfix,search,tag,undo

" Make 5 lines visible around the current cursor position.
set scrolloff=10

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

" See all sessions with Ctrl-S.
map <C-S> :CtrlPSession<cr>

" UNIX line endings by default.
set fileformats=unix,dos
set fileformat=unix

" Fixes an issue with the quickfix windows with Go.
let g:go_list_type = "quickfix"

" Go bindings.
augroup gosyntax
	au!
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
let g:go_auto_type_info = 1

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable ALE integration with airline.
let g:airline#extensions#ale#enabled = 1

" Tell easytags to operate in the background.
let g:easytags_async=1
let g:easytags_events = ['BufWritePost']

" Configure tags per project.
let g:easytags_dynamic_files=2

" function! s:generate_repo_tags()
" 	let l:repo = fugitive#repo()
" 	let l:repo_files = split(system(l:repo.git_command('ls-files', '-oc', '--exclude-standard'), '[^\r\n]*'), '\n')
" 	call xolox#easytags#update(0, 0, l:repo_files)
" endfunction

" function! g:set_tags_file()
" 	try
" 		let l:repo = fugitive#repo()
" 		let l:root_dir = fnamemodify(l:repo.git_dir, ":h")
" 		let l:tags_file = l:root_dir.".tags"
" 		command! -b GenerateTags call s:generate_repo_tags()
" 	catch
" 		if has("win32") || has("win16")
" 			let l:tags_file = "~/_vimtags"
" 		else
" 			let l:tags_file = "~/.vimtags"
" 		endif
" 	endtry

" 	execute ':setlocal tags='.l:tags_file
" endfunction

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
augroup pythonsyntax
	au!
	autocmd FileType python set colorcolumn=80
	autocmd FileType python setlocal foldmethod=indent
	autocmd FileType python setlocal foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g')
augroup end

" Completion options.
set completeopt=longest,menu

" Remap Ctrl+C and Ctrl+X to copy/cut via XMing
vmap <C-C> "*y
vmap <C-X> "*c
