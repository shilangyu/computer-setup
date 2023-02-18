call plug#begin()
    Plug 'rust-lang/rust.vim'
    Plug 'fatih/vim-go'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'dag/vim-fish'
    Plug 'airblade/vim-gitgutter'
    Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

set termguicolors

colorscheme dracula

let g:rustfmt_autosave = 1
syntax on
set scrolloff=10
set number relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set linebreak
set mouse=a

set undodir=~/.cache/nvim/.undofile
set undofile
