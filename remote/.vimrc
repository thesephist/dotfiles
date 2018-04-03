set ignorecase
set smartcase
set hlsearch
set showmatch
set encoding=utf8
set ffs=unix,dos,mac
set hidden
set ruler
set scrolloff=4
set incsearch
set magic
set nowrap
set expandtab
set shiftwidth=4
set tabstop=4
set backspace=start,eol,indent
set number
set relativenumber
set ai
filetype indent on

" FILETYPES
" ===
" /ftplugin/html.vim
" set shiftwidth=2
" set tabstop=2
" ===

map ss :setlocal spell!<cr>
map ff :DiffOrig<cr>
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

