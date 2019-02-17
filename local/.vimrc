" For Vundle Plugins 
" ===
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe' " polyglot token-based autocomplete
Plugin 'jiangmiao/auto-pairs' " pair parens/brackets/braces
Plugin 'airblade/vim-gitgutter' " show git diff status in the left side gutter
Plugin 'joshdick/onedark.vim'  " atom-style One Dark color theme
Plugin 'pseewald/vim-anyfold' " smarter line folding
Plugin 'scrooloose/nerdtree' " smarter file explorer
Plugin 'Xuyuanp/nerdtree-git-plugin' " show git statuses for files in NERDTree
Plugin 'vim-airline/vim-airline' " airline theme for vim status line
Plugin 'sheerun/vim-polyglot' " solid language pack
Plugin 'mattn/emmet-vim' " emmet expander for HTML / CSS
Plugin 'pangloss/vim-javascript' " JavaScript enhancements, including jsdoc

" If used inside Tmux, this shows the vim airline statusline in Tmux's
" statusline
Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" / search options
set ignorecase
set smartcase
set hlsearch
set showmatch

" file settings
set encoding=utf8
set ffs=unix,dos,mac

" display options
set nowrap
set hidden
set ruler
set scrolloff=4
set incsearch
set magic
set number
set ai

" tab and whitespace options
set expandtab
set shiftwidth=4
set tabstop=4
set backspace=start,eol,indent
filetype indent on

" shortcuts
map ss :setlocal spell!<cr>
map ff :DiffOrig<cr>
map fh :set guifont=Fira\ Code:h11<cr>
map fl :set guifont=Fira\ Code:h16<cr>
map yy :setlocal list!<cr>
map U :b#<cr>
map W <C-w>

syntax on
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

if !exists(":DiffOrig")
      command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

autocmd BufNewFile,BufRead *.md set filetype=markdown

" Plugin commands
:colorscheme onedark
" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
set laststatus=2

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" NerdTREE
" auto-open on open of directlry
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close if only tree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open automatically if no file / dir specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" key map to Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" vim-anyfold
let AnyFoldActivate=1
set foldlevel=10

let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\coverage']
map , jA,k

let g:javascript_plugin_jsdoc=1

set path=./**
set wildignore+=**/coverage/**,**/node_modules/**

" Addresses some vim redraw issues inside 256color terminals
set term=xterm-256color

