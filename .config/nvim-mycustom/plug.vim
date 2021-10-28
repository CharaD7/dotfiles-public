if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-rhubarb'

if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neovim/nvim-lspconfig', {'do': './install.sh'}
  Plug 'glepnir/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  " Plug 'kyazdani42/nvim-tree.lua'
  " Plug 'kyazdani42/nvim-web-devicons'
  Plug 'preservim/nerdtree'
  " Reach support
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  " Reach language support
  Plug 'chrisnevers/language-reach'
  Plug 'tpope/vim-surround'
  Plug 'valloric/youcompleteme'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'scrooloose/nerdtree-project-plugin'
  Plug 'PhilRunninger/nerdtree-buffer-ops'
  Plug 'PhilRunninger/nerdtree-visual-selection'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'tpope/vim-commentary'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'sharkdp/fd'
  Plug 'windwp/nvim-autopairs'
endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
