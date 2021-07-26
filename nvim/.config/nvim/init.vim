syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set nohlsearch
set relativenumber
set nu
set hidden
set nowrap
set noerrorbells
set incsearch
set scrolloff=8
set signcolumn=yes
set termguicolors
set noshowmode

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'airblade/vim-gitgutter'

call plug#end()

colorscheme onedark    
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
highlight Normal guibg=none

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>

