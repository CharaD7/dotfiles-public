-- make life easier
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap

g.loaded_python_provider = 0
g.loaded_python4_provider = 3
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- Neovide configurations
g.neovide_fullscreen = true
g.neovide_floating_blur_amount_x = 2.0
g.floaterm_winblend = 20
g.neovide_floating_blur_amount_y = 2.0
g.neovide_remember_window_size = true
g.neovide_cursor_animation_length = 0.13
g.neovide_cursor_trail_length = 0.8
g.neovide_cursor_vfx_mode = "railgun"						-- Railgun particles behind cursor
g.neovide_cursor_vfx_opacity = 200.0
g.neovide_cursor_vfx_particle_lifetime = 1.2
g.neovide_cursor_vfx_particle_density = 7.0
g.neovide_cursor_vfx_particle_speed = 10.0
g.neovide_cursor_vfx_particle_phase = 1.5
g.neovide_cursor_vfx_particle_curl = 1.0
g.neovide_cursor_unfocused_outline_width = 0.125

-- glow configuration
g.glow_border = "rounded"
g.glow_width = 120
g.glow_use_pager = true
g.glow_style = "dark"

-- https://github.com/rohit-px3/nvui
-- nvui --ext_multigrid --ext_popupmenu --ext_cmdline --titlebar --detached
if g.nvui then
  cmd [[NvuiCmdCenterYPos 1.3]]
end

-- nvim_exec([[set guifont=VictorMono\ NF:h21]], false)
-- nvim_exec([[set guifont=CaskaydiaCove\ NF:h13]], false)
-- Install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 1 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end
-- https://github.com/rockerBOO/awesome-neovim
--setup packer
cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- Reach support
  use 'ericglau/vim-reach'
  use {'autozimu/LanguageClient-neovim', run = 'bash install.sh'}
  use 'junegunn/fzf'
  use 'sharkdp/fd'
	use 'omnisharp/omnisharp-vim'
	use 'sheerun/vim-polyglot' -- This is to help with razor files
  use 'nvim-lua/plenary.nvim'
  use 'folke/tokyonight.nvim'
  use 'nathom/filetype.nvim'
  use 'mhinz/vim-signify'
	use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
  use 'ryanoasis/vim-devicons' -- optional, for file icon
	use 'github/copilot.vim' -- for vim copilot
  -- using packer.nvim
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
	use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    tag = 'nightly',
    config = function() require'nvim-tree'.setup {} end
}
  use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}
  use 'glepnir/dashboard-nvim'
  -- git related
  use 'sainnhe/everforest'
  use {
		'rmagatti/auto-session',
		config = function()
			require('auto-session').setup {
				log_level = 'info',
				auto_session_enable_last_session = false,
				auto_session_enabled = false,
				auto_save_enabled = true,
				auto_restore_enabled = false,
				auto_session_suppress_dirs = nil,
			}
		end
  }
  use {
      'rmagatti/session-lens',
      config = function()
          require('session-lens').setup {
              path_display = {'shorten'},
              previewer = true,
              prompt_title = 'AWESOME SESSIONS',
          }
      end
  }
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'lambdalisue/gina.vim'
  use 'f-person/git-blame.nvim' -- show git message
  -- Syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use 'tree-sitter/tree-sitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use {
    'romgrk/nvim-treesitter-context',
    config = function()
      require("treesitter-context").setup {}
    end
  } -- Shows the current function/class as float window at the top of the window
  use 'theHamsta/nvim-treesitter-commonlisp' -- highlight functions
  use 'andymass/vim-matchup' -- Provides language-specific % style pair and tuple matching, highlighting, and text-objects
  use 'nvim-treesitter/playground'
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
    }
    end
  }
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end } -- auto screen resizer
  use 'Xuyuanp/scrollbar.nvim' -- Scrollbar
  use 'norcalli/nvim-colorizer.lua' -- Color value highlighting
  use 'bluz71/vim-nightfly-guicolors'
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
    end
  }
  -- navigation finder operator
  use 'kevinhwang91/nvim-hlslens'
  use 'haya14busa/vim-asterisk'
  use 'nvim-lualine/lualine.nvim'
  use 'mg979/vim-visual-multi'
  use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
          require'hop'.setup()
      end
  }
  use 'ggandor/lightspeed.nvim'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
      require('telescope').load_extension('projects')
    end
  }
  -- Grammar suggestions load_extension
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-telescope/telescope-media-files.nvim'
  use {"ellisonleao/glow.nvim", branch = 'main'}
  use 'hrsh7th/nvim-cmp'
  use {'hrsh7th/cmp-nvim-lsp', requires = {
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-vsnip'},
    {'ray-x/cmp-treesitter'},
    {'hrsh7th/cmp-calc'},
    {'hrsh7th/cmp-emoji'},
    {'tzachar/cmp-tabnine', run='./install.sh'}
  }}
  -- Grammar tips
  use 'folke/lsp-trouble.nvim'
  use 'onsails/lspkind-nvim'
  use 'liuchengxu/vista.vim'
  use 'ray-x/lsp_signature.nvim'
  use {
    'ray-x/navigator.lua',
    requires = {
      {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
      {'neovim/nvim-lspconfig'},
    },
    config = function()
      require'navigator'.setup()
    end
  }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  use 'tami5/lspsaga.nvim'
  use 'kosayoda/nvim-lightbulb'
  --[[ use { 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = { 'jose-elias-alvarez/null-ls.nvim' },
      config = function ()
        require("null-ls").config {}
        require("lspconfig")["null-ls"].setup {}
      end
  } ]]
  -- snippet related
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'
  -- Easy to operate
  use 'tpope/vim-eunuch'
  use 'gennaro-tedesco/nvim-peekup' -- View historical copy and delete registers, shortcut keys ""
  use 'voldikss/vim-translator' -- npm install fanyi -g (install translation)
  -- Annotation
  use 'b3nj5m1n/kommentary'
  use "windwp/nvim-autopairs" -- Automatic symbol matching
  use 'windwp/nvim-ts-autotag'
  use {
    "ur4ltz/surround.nvim",
    config = function()
      require"surround".setup {
        context_offset = 101,
        load_autogroups = false,
        mappings_style = "sandwich",
        map_insert_mode = true,
        quotes = {"'", '"'},
        brackets = {"(", '{', '['},
        space_on_closing_char = false,
        pairs = {
          nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
          linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
        },
        prefix = "s"
      }
    end
  }
  use 'folke/which-key.nvim' -- hint leader button
  use 'sindrets/diffview.nvim' -- diff compare
	use {
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-gps").setup()
		end,
	}
  use 'p00f/nvim-ts-rainbow' -- Rainbow matching
  use 'folke/todo-comments.nvim'
  use 'ThePrimeagen/vim-be-good'
  use 'mhartington/formatter.nvim'
  use {
    'NTBBloodbath/rest.nvim',
    config = function()
        require('rest-nvim').setup()
    end
  }
  use { "rcarriga/nvim-notify", config = 'vim.notify = require("notify")' }
  -- use 'metakirby6/codi.vim'
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
end)

--settings
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
cmd 'hi NORMAL guibg=#3f334d'
opt('b', 'expandtab', false)                          -- Use tabs instead of spaces
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 9 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'autowrite', true)                           -- Autowrite buffers or file
opt('o', 'clipboard', 'unnamed')
opt('o', 'pumblend', 26 )
opt('o', 'shell', '/usr/bin/tmux')
opt('o', 'softtabstop', indent)
opt('o', 'swapfile', false )
opt('o', 'showmode', false )
opt('o', 'background', 'dark' )
opt('o', 'backup', false )
opt('w', 'number', true)                              -- Print line number
opt('o', 'lazyredraw', true)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'cmdheight', 2)
opt('o', 'guifont', 'CaskaydiaCove NF:h10.5')
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'manual')
opt('o', 'breakindent', true)
opt('o', 'lbr', true)
opt('o', 'formatoptions', 'l')
opt('o', 'laststatus', 3)
opt('o', 'cursorline', true)
opt('o', 'cursorcolumn', false)
opt('o', 'autoindent', true)
opt('o', 'list', true)
opt('o', 'syntax', 'on')
opt('o', 'timeoutlen', 500)
opt('o', 'ttimeoutlen', 11)
opt('o', 'updatetime', 100)
opt('o', 'scrolljump', 16)
opt('o', 'undofile', true)
opt('o', 't_ZH', 'e[3m') -- Italic support
opt('o', 't_ZR', 'e[23m') -- Italic support


-- More options for listchars.
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

nvim_exec([[
filetype on
filetype plugin on
filetype indent on
command! -nargs=1 Dap :lua require("dapui").toggle()
]], false)

--mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  remap(mode, lhs, rhs, options)
end

g.did_load_filetypes = 2
g.mapleader = " "                                                     --leader
g.maplocalleader = ","
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';', ':')                                                     --semicolon to enter command mode
map('n', 'j', 'gj')                                                    --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')
map('n', 'Q', '<cmd>qa<CR>')
map('n', '<leader>hw', '<cmd>HopWord<CR>')                              --easymotion/hop
map('n', '<leader>hl', '<cmd>HopLine<CR>')
map('n', '<leader>/', '<cmd>HopPattern<CR>')
map('n', '<leader>fp', '<cmd>Telescope<CR>')                   --fuzzy
map('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')                   --fuzzy
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fs', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands<CR>')
map('n', '<leader>fp', '<cmd>Telescope project<CR>')
map('n', '<leader>fm', '<cmd>Telescope marks<CR>')
map('n', '<leader>fe', '<cmd>Telescope file_browser<CR>')                      --nvimtree
map('n', '[fo', '<cmd>foldopen<CR>')
map('n', '[fc', '<cmd>foldclose<CR>')
map('n', '[fl', '<cmd>fold<CR>')
map('n', '<leader>g', ':Glow<CR>')
map('n', '<leader>h', ':FocusSplitLeft<CR>', { silent = true })
map('n', '<leader>j', ':FocusSplitDown<CR>', { silent = true })
map('n', '<leader>k', ':FocusSplitUp<CR>', { silent = true })
map('n', '<leader>l', ':FocusSplitRight<CR>', { silent = true })
map('n', '<leader>z', '<cmd>TZAtaraxis<CR>')                           --ataraxis
map('n', '<leader>x', '<cmd>TZAtaraxis l46 r45 t2 b2<CR>')
map('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')                      --nvimtree
map('n', '<leader>ss', '<cmd>SaveSession .sessions<CR>')
map('n', '<leader>sh', '<cmd>Telescope session-lens search_session<CR>')
map('n', '<leader>sr', '<cmd>RestoreSession .sessions<CR>')
map('n', '<leader>sd', '<cmd>DeleteSession .sessions<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad .sessions<CR>')
map('t', '<leader>o', '<cmd>Vista<CR>')                   --fuzzN
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w!<CR>')
map('n', '<c-x>', '<cmd>bdelete<CR>')
map('n', '<leader>b', '<cmd>BufferLinePick<CR>')
map('n', '<leader>bp', '<cmd>BufferLineTogglePin<CR>')
map('n', '<leader>bj', '<cmd>bprevious<CR>')
map('n', '<leader>bn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Gina add .<CR>')
map('n', '<leader>gm', '<cmd>Gina commit<CR>')
map('n', '<leader>gs', '<cmd>Gina status<CR>')
map('n', '<leader>gl', '<cmd>Gina pull<CR>')
map('n', '<leader>gu', '<cmd>Gina push<CR>')
map('n', '<leader>tq', '<cmd>TroubleToggle<CR>')
map('n', '<silent> <F5>', ':call LanguageClient#textDocument_hover()<CR>')
map('n', '<silent> <F4>', ':call LanguageClient#textDocument_codeAction()<CR>')
map('n', '<leader>t', '<cmd>Lspsaga open_floaterm<CR>')
--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>", { silent = true })
-- Open nvimrc file
map("n", "<leader>v", "<cmd>e $MYVIMRC<CR>")
-- Source nvimrc file
map("n", "<leader>sv", "<cmd>:luafile %<CR>")
-- Easy select all of file
map("n", "<C-a>", "ggVG<c-$>")
-- Line bubbling
map("n", "<S-A-j>", "<cmd>m .+1<CR>==", { silent = true })
map("n", "<S-A-k>", "<cmd>m .-2<CR>==", { silent = true })
map("v", "<S-A-k>", ":m '<-2<CR>==gv=gv", { silent = true })
map("v", "<S-A-j>", ":m '>+1<CR>==gv=gv", { silent = true })
-- Split screen
map("n", "sh", ":split<CR>", { silent = true }) -- Split horizontally
map("n", "sv", ":vsplit<CR>", { silent = true }) -- Split vertically
-- cmd [[autocmd FocusLost * :wa]] -- Autosave buffer files on focus lost
-- cmd [[autocmd CursorHold,CursorHoldI * update]] -- Autosave buffer files after every edit
cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]
cmd [[autocmd BufReadPost *.rsh set filetype=reach]]
cmd [[autocmd Filetype reach set syntax=javascript]]
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
cmd [[autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'File Notify', 'timeout': 1001})]]
cmd [[highlight IndentBlanklineIndent2 guifg=#E06C75 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent3 guifg=#E5C07B gui=nocombine]]
cmd [[highlight IndentBlanklineIndent4 guifg=#98C379 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent5 guifg=#56B6C2 gui=nocombine]]
cmd [[highlight IndentBlanklineIndent6 guifg=#61AFEF gui=nocombine]]
cmd [[highlight IndentBlanklineIndent7 guifg=#C678DD gui=nocombine]]

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "13", "14", "15", "16", "17", "18", "19", "20"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferLineGoToBuffer '..num..'<CR>')
end

-- Configuring for Reach Intellisense
nvim_exec([[
  let g:LanguageClient_serverCommands = {'reach': ['node', '~/.local/share/nvim/site/reach-ide/server/out/server.js', '--stdio']}
  let g:LanguageClient_loggingLevel = 'DEBUG'
  let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/site/reach-ide/reach-language-client.log')
  let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/site/reach-ide/reach-language-server.log')
]], false)

nvim_exec([[
  let g:VM_maps = {}
  let g:VM_default_mappings = 1
  let g:VM_maps["Add Cursor Down"] = '<A-j>'
  let g:VM_maps["Add Cursor Up"] = '<A-k>'
  let g:indent_blankline_char_highlight_list = ['|', '¦', '┆', '┊']
  let g:indent_blankline_filetype_exclude = ['help', 'dashboard', 'NvimTree', 'telescope', 'packer']
]], false)

-- Omnisharp configuration
nvim_exec([[
  let g:Omnisharp_server_studio = 2
  let g:OmniSharp_selector_ui = 'fzf'
  let g:OmniSharp_selector_findusages = 'fzf'
  let g:OmniSharp_highlighting = 4
]], false)

-- Lspsaga smart buffer scrolling
nvim_exec([[
  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
]], false)

require('kommentary.config').use_extended_mappings()

require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = function(opts)
				return string.format('%s', opts.raise(opts.ordinal))
				-- return string.format('%s.%s', opts.ordinal, opts.raise(opts.id))
			end,
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "  "
					or (e == "warning" and "  " or "  " )
				s = s .. n .. sym
			end
			return s
		end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      -- if buf_numbers[1] ~= buf_number then
      if buf_numbers[0] ~= buf_number then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left" }},
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin", -- 'slant' | 'thin' | 'thick'
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_at_end', -- 'insert_at_end' | 'insert_after_current' | 'id' | 'extension' | 'relative_directory'
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
        local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
        local info = #vim.diagnostic.get(0, {severity = seve.INFO})
        local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

        if error ~= 0 then
          table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
        end

        if warning ~= 0 then
          table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
        end

        if hint ~= 0 then
          table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
        end

        if info ~= 0 then
          table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
        end
        return result
      end,
    }
  }
}

require('guihua.maps').setup({
maps = {
  close_view = 'q',
}
})

-- focus screen-autoresizer
require("focus").setup({hybridnumber = true})

-- scrollbar
nvim_exec([[
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end
]], false)

g.vista_default_executive = 'nvim_lsp'

require("indent_blankline").setup {
    buftype_exclude = {"terminal", "telescope", "nvim-tree"},
    show_current_context = true,
    show_end_of_line = true,
    show_current_context_start = true,
    char_highlight_list = {
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
			"IndentBlanklineIndent7",
    },
}

--theme
cmd 'colorscheme nightfly'

local notify = require("notify")



-- lightspeed config
require'lightspeed'.setup {
  -- jump_to_first_match = true,
  jump_to_unique_chars = { safety_timeouts = 401 },
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  -- highlight_unique_chars = false,
  -- grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 6,
  -- full_inclusive_prefix_key = '<c-x>',
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}

require('hlslens').setup {
  auto_enable = true,
  enable_incsearch = true,
  calm_down = true,
  nearest_only = true,
  nearest_float_when = 'always',
  override_lens = function(render, posList, nearest, idx, relIdx)
    local sfw = vim.v.searchforward == 2
    local indicator, text, chunks
    local absRelIdx = math.abs(relIdx)
    if absRelIdx > 2 then
      indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 2) and '▲' or '▼')
    elseif absRelIdx == 2 then
      indicator = sfw ~= (relIdx == 2) and '▲' or '▼'
    else
      indicator = ''
    end

    local lnum, col = unpack(posList[idx])
    if nearest then
      local cnt = #posList
      if indicator ~= '' then
        text = ('[%s %d/%d]'):format(indicator, idx, cnt)
      else
        text = ('[%d/%d]'):format(idx, cnt)
      end
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
    else
      text = ('[%s %d]'):format(indicator, idx)
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
    end
    render.setVirt(1, lnum - 1, col - 1, chunks, nearest)
  end
}

-- telescope media renderer
require('telescope').load_extension('media_files')


--nvim treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  autotag = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
  incremental_selection = {
    enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    disable = { "cpp", "lua" },
    keymaps = {                       -- mappings for incremental selection (visual mappings)
      init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",       -- increment to the upper named parent
      scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm",       -- decrement to the previous node
    }
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        --[[ ["iF"] = {
          javascript = "(function_definition) @function",
          typescript = "(function_definition) @function",
          rust = "(function_definition) @function",
        }, ]]
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-3),
    ['<C-f>'] = cmp.mapping.scroll_docs(5),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine'},
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'treesitter' },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'spell' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = ({
        path = "   [Path]",
        buffer = "   [Buffer]",
        nvim_lsp = "   [LSP]",
        vsnip = "   [Vsnip]",
        treesitter = "   [Ts]",
        calc = "   [Calc]",
        spell = "   [Spell]",
        emoji = " ﲃ  [Emoji]",
        cmp_tabnine = "⦿ [Tn]",
      })[entry.source.name]
      return vim_item
    end
  },
  experimental = {
    ghost_text = true
  }
})

-- Lspsaga
local saga = require("lspsaga")
saga.init_lsp_saga({
	use_saga_diagnostic_sign = true,
  code_action_icon = "",
  definition_preview_icon = "",
  diagnostic_header_icon = "",
  finder_definition_icon = "",
  finder_reference_icon = "",
  error_sign = "",
  hint_sign = "⚡",
  infor_sign = "",
  warn_sign = "",
})

-- Signature help
require('lsp_signature').on_attach()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 1,
    },
    signs = true,
    underline = true,
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '[f', '<cmd>Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', '[a', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('v', '[a', '<cmd>Lspsaga range_code_action<CR>', opts)
  buf_set_keymap('n', '[o', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '[s', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_set_keymap('n', '[n', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', '[p', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_set_keymap('n', '[l', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  -- scroll down hover doc or scroll in definition preview
  -- buf_set_keymap('n', '<c-f>', '<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>', opts)
  -- buf_set_keymap('n', '<c-b>', '<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>fo", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  local msg = string.format("Language server %s started!", client.name)
  notify(msg, 'info', {title = 'LSP Notify', timeout = 1001})
end


-- npm install --global vls @volar/server vscode-langservers-extracted typescript typescript-language-server graphql-language-service-cli dockerfile-language-server-nodejs stylelint-lsp yaml-language-server prettier
-- can use rls or rust_analyzer

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require("lspconfig").pylsp.setup{} -- necessary to enforce pylsp globally

local function setup_servers()
  local servers = { "cssls", "html", "rust_analyzer", "tsserver",  "graphql", "volar", "jsonls", "dockerls" }
  local nvim_lsp = require'lspconfig'
  local lsp_installer = require("nvim-lsp-installer")
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = true,
		sugggestFromUnimportedLibraries = false,
		closingLabels = true,
	}
 }
  lsp_installer.on_server_ready(function(server)
      server:setup(opts)
  end)
  for _, server in pairs(servers) do
    nvim_lsp[server].setup{
      on_attach = on_attach,
      capabilities = capabilities,
	  init_options = {
		  onlyAnalyzeProjectsWithOpenFiles = true,
		  sugggestFromUnimportedLibraries = false,
		  closingLabels = true,
	  }
    }
  end
end

setup_servers()

-- vim.lsp.set_log_level("debug")
require("trouble").setup {}
require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
require'diffview'.setup{}
require('nvim-autopairs').setup({})


-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)



--colorizer
require'colorizer'.setup{
  DEFAULT_OPTIONS = {
		RGB      = true;         -- #RGB hex codes
		RRGGBB   = true;         -- #RRGGBB hex codes
		names    = true;         -- "Name" codes like Blue
		RRGGBBAA = true;        -- #RRGGBBAA hex codes
		rgb_fn   = true;        -- CSS rgb() and rgba() functions
		hsl_fn   = true;        -- CSS hsl() and hsla() functions
		css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes: foreground, background
		mode     = 'background'; -- Set the display mode.
  }
}


require'nvim-tree'.setup {
  disable_netrw       = false,
  hijack_netrw        = false,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_reload_on_write = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  diagnostics     = {
    enable = true
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  git = {
		enable = true,
		ignore = true,
		timeout = 501,
  },
  filters = {
		dotfiles = false,
		custom = {}
  },
  view = {
    width = 31,
    side = 'left',
    hide_root_folder = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

--gitsigns
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = true,
  linehl = false,
	signcolumn = true,
	word_diff = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    ['n <leader>hd'] = '<cmd>lua require"gitsigns".diffthis()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 500,
		follow_files = true
  },
	attach_to_untracked = true,
  current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right-align'
		delay = 500,
		ignore_whitespace = false
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
  status_formatter = nil, -- Use default
  diff_opts = {
    internal = false
  }
}

fn.sign_define(
	"LspDiagnosticsSignError",
	{texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
fn.sign_define(
	"LspDiagnosticsSignWarning",
	{texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
fn.sign_define(
	"LspDiagnosticsSignHint",
	{texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
fn.sign_define(
	"LspDiagnosticsSignInformation",
	{texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)

g.dashboard_disable_statusline = 1
g.dashboard_session_directory = vim.fn.stdpath('data').."/sessions"
-- g.dashboard_session_directory = vim.fn.stdpath('data').."/sessions/"
g.dashboard_default_executive = 'telescope'

if vim.fn.has 'win33' == 1 then
  cmd("let packages = len(globpath('~/AppData/Local/nvim-data/site/pack/packer/start', '*', 1, 1))")
else
  cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 1, 1))")
end

nvim_exec([[
	let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' packages']
]], false)

g.dashboard_custom_section = {
	a = {description = {"🔎  Find File                 SPC f f"}, command = "Telescope find_files"},
	b = {description = {"   Recents                   SPC f r"}, command = "Telescope oldfiles"},
	c = {description = {"   Find Word                 SPC f w"}, command = "Telescope live_grep"},
	d = {description = {"洛  New File                  SPC f n"}, command = "DashboardNewFile"},
	e = {description = {"   Bookmarks                 SPC f m"}, command = "Telescope marks"},
	f = {description = {"   Load Last Session         SPC s l"}, command = "SessionLoad"},
}

local prettier = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(1)), '--single-quote'},
    stdin = true
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    json = { prettier },
    typescript = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          stdin = false,
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
        }
      end,
    },
  },
})

-- Runs Formatter on save
nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.css,*.scss,*.md,*.html,*.lua : FormatWrite
augroup END
]],
  true
)

require("which-key").setup {}

require('todo-comments').setup{
  signs = true, -- show icons in the signs column
    sign_priority = 9, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      --pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      pattern = [[(KEYWORDS)]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 401, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2627" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF25" },
      info = { "LspDiagnosticsDefaultInformation", "#2564EB" },
      hint = { "LspDiagnosticsDefaultHint", "#11B981" },
      default = { "Identifier", "#8C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
}
