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
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'airblade/vim-gitgutter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'chrisbra/Colorizer'

nnoremap <SPACE> <Nop>
let mapleader = " "

call plug#end()

colorscheme onedark    
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
highlight Normal guibg=none

nnoremap <leader>ff <cmd>lua require('telescope.builtin').git_files()<cr>

set completeopt=menu,menuone,noselect

lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
})
require'lspconfig'.tsserver.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
require'lspconfig'.clangd.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
EOF
