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
  Plug 'RishabhRD/popfix'
  Plug 'RishabhRD/nvim-lsputils'
  Plug 'folke/lsp-colors.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  " Reach support
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  " Reach language support
  Plug 'chrisnevers/language-reach'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'junegunn/fzf'
  Plug 'Yggdroot/indentLine'
  Plug 'valloric/youcompleteme'
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'b3nj5m1n/kommentary'
  Plug 'hrsh7th/nvim-compe'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'mhartington/formatter.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'rmagatti/auto-session'
  Plug 'sainnhe/everforest'
  Plug 'folke/tokyonight.nvim'
  Plug 'sharkdp/fd'
  " NERDTree
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'scrooloose/nerdtree-project-plugin'
  Plug 'PhilRunninger/nerdtree-buffer-ops'
  Plug 'PhilRunninger/nerdtree-visual-selection'
  " React and Typescript snippets hook
  Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/nvim-compe'
  Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
  Plug 'autozimu/LanguageClient-neovim'
endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
