call plug#begin('~/local/share/nvim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
call plug#end()

let g:rustfmt_autosave = 1
syntax on
set scrolloff=10
set number relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
