-- make life easier
local cmd = vim.cmd
local g = vim.g
-- local execute = vim.api.nvim_command
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
-- g.neovide_transparency = 0.8
g.neovide_cursor_animation_length = 0.13
g.neovide_cursor_trail_length = 0.8
g.neovide_cursor_vfx_mode = "railgun" -- Railgun particles behind cursor
g.neovide_cursor_vfx_opacity = 200.0
g.neovide_cursor_vfx_particle_lifetime = 1.2
g.neovide_cursor_vfx_particle_density = 7.0
g.neovide_cursor_vfx_particle_speed = 10.0
g.neovide_cursor_vfx_particle_phase = 1.5
g.neovide_cursor_vfx_particle_curl = 1.0
g.neovide_cursor_unfocused_outline_width = 0.125

-- bracey configurations
g.bracey_server_allow_remote_connections = 0
g.bracey_auto_start_server = 1
g.bracey_eval_on_save = 1
g.bracey_refresh_on_save = 1
g.bracey_auto_start_browser = 1

-- glow configuration
g.glow_border = "rounded"
g.glow_width = 120
g.glow_use_pager = true
g.glow_style = "dark"

cmd("let &runtimepath = &runtimepath")

-- in millisecond, used for both CursorHold and CursorHoldI,

-- https://github.com/rohit-px3/nvui
-- nvui --ext_multigrid --ext_popupmenu --ext_cmdline --titlebar --detached
if g.nvui then
	cmd([[NvuiCmdCenterYPos 1.3]])
end

-- Install packer
-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print("Installing packer...")
	local packer_url = "https://github.com/wbthomason/packer.nvim"
	vim.fn.system({ "git", "clone", "--depth", "1", packer_url, install_path })
	print("Done.")

	vim.cmd("packadd packer.nvim")
	install_plugins = true
end

-- Autocommand that reloads neovim whenever you save the init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd VimEnter * source $MYVIMRC
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

-- https://github.com/rockerBOO/awesome-neovim
--setup packer
-- execute('packadd packer.nvim')
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	-- Reach support
	use("ericglau/vim-reach")
	use({ "autozimu/LanguageClient-neovim", run = "bash install.sh" })
	use("junegunn/fzf")
	use("sharkdp/fd")
	use("omnisharp/omnisharp-vim")
	use("sheerun/vim-polyglot") -- This is to help with razor files
	use("nvim-lua/plenary.nvim")
	use("turbio/bracey.vim") --	For live serving HTML and JavaScript documents
	-- use 'folke/tokyonight.nvim'
	use("nathom/filetype.nvim")
	use("mhinz/vim-signify")
	use("MunifTanjim/prettier.nvim")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("SmiteshP/nvim-navic")
	use("ryanoasis/vim-devicons") -- optional, for file icon
	use({ "github/copilot.vim", run = ":Copilot setup" }) -- for vim copilot
	-- using packer.nvim
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly",
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	use({ "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install && yarn compile" })
	use("vscode-langservers/vscode-css-languageserver-bin")
	use("glepnir/dashboard-nvim")
	-- git related
	use("sainnhe/everforest")
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_enable_last_session = true,
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_restore_enabled = true,
				auto_session_suppress_dirs = nil,
			})
		end,
	})
	use({
		"rmagatti/session-lens",
		config = function()
			require("session-lens").setup({
				path_display = { "shorten" },
				previewer = true,
				prompt_title = "AWESOME SESSIONS",
			})
		end,
	})
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("tpope/vim-repeat")
	use("tpope/vim-fugitive")
	use("lambdalisue/gina.vim")
	use("f-person/git-blame.nvim") -- show git message
	-- Syntax highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- use 'tree-sitter/tree-sitter'
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-treesitter-refactor")
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({})
		end,
	}) -- Shows the current function/class as float window at the top of the window
	use("theHamsta/nvim-treesitter-commonlisp") -- highlight functions
	use("andymass/vim-matchup") -- Provides language-specific % style pair and tuple matching, highlighting, and text-objects
	use("nvim-treesitter/playground")
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})
	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup()
		end,
	}) -- auto screen resizer
	use("Xuyuanp/scrollbar.nvim") -- Scrollbar
	use("norcalli/nvim-colorizer.lua") -- Color value highlighting
	use("bluz71/vim-nightfly-guicolors")
	use({ "lukas-reineke/indent-blankline.nvim", config = function() end })
	-- navigation finder operator
	use("kevinhwang91/nvim-hlslens")
	use("haya14busa/vim-asterisk")
	use("nvim-lualine/lualine.nvim")
	use("mg979/vim-visual-multi")
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("hop").setup()
		end,
	})
	use("ggandor/lightspeed.nvim")
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } })
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
			require("telescope").load_extension("projects")
		end,
	})
	-- Noice
	use({
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("noice").setup()
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})
	-- Java support
	use("mfussenegger/nvim-jdtls")
	use("artur-shaik/jc.nvim")
	-- Grammar suggestions load_extension
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("nvim-telescope/telescope-media-files.nvim")
	use({ "ellisonleao/glow.nvim", branch = "main" })
	use("xiyaowong/nvim-transparent")
	use("quangnguyen30192/cmp-nvim-ultisnips")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"hrsh7th/cmp-nvim-lsp",
		requires = {
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			-- { 'hrsh7th/cmp-vsnip' },
			{ "ray-x/cmp-treesitter" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-emoji" },
			{ "tzachar/cmp-tabnine", run = "./install.sh" },
		},
	})
	use("xiyaowong/telescope-emoji.nvim") -- allow looking up and using emojies inside out files
	-- Grammar tips
	use("folke/lsp-trouble.nvim")
	use("onsails/lspkind-nvim")
	use("liuchengxu/vista.vim")
	use("ray-x/lsp_signature.nvim")
	use("pantharshit00/vim-prisma") -- prisma support
	use({
		"ray-x/navigator.lua",
		requires = {
			{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		},
		config = function()
			require("navigator").setup()
		end,
	})
	use("antoinemadec/FixCursorHold.nvim") -- Fix neovim's CursorHold issues
	use("mtth/scratch.vim") -- For taking notes (Uses 'gs' to invoke command)
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			require("nvim-code-action").setup()
		end,
	})
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	-- use 'frabjouv/knap' -- For live serving Markdown, Latex, PDF and HTML files
	-- use 'tami5/lspsaga.nvim'
	use("kosayoda/nvim-lightbulb")
	-- use("jose-elias-alvarez/null-ls.nvim") -- snippet related use 'hrsh7th/vim-vsnip'
	use("hrsh7th/cmp-cmdline")
	use("rafamadriz/friendly-snippets")
	-- Easy to operate
	use("tpope/vim-eunuch")
	use("gennaro-tedesco/nvim-peekup") -- View historical copy and delete registers, shortcut keys ""
	use("voldikss/vim-translator") -- npm install fanyi -g (install translation)
	use("windwp/nvim-autopairs") -- Automatic symbol matching
	use("windwp/nvim-ts-autotag")
	use({
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({
				context_offset = 101,
				load_autogroups = false,
				mappings_style = "sandwich",
				map_insert_mode = true,
				quotes = { "'", '"' },
				brackets = { "(", "{", "[" },
				space_on_closing_char = true,
				pairs = {
					nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
					linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
				},
				prefix = "s",
			})
		end,
	})
	use("folke/which-key.nvim") -- hint leader button
	use("sindrets/diffview.nvim") -- diff compare
	use({
		"SmiteshP/nvim-gps",
		config = function()
			require("nvim-gps").setup()
		end,
	})
	use("p00f/nvim-ts-rainbow") -- Rainbow matching
	use("folke/todo-comments.nvim")
	use("ThePrimeagen/vim-be-good")
	-- Give me some glepnir beauty in there
	use("glepnir/zephyr-nvim")
	use({
		"NTBBloodbath/rest.nvim",
		config = function()
			require("rest-nvim").setup()
		end,
	})
	use({ "rcarriga/nvim-notify", config = 'vim.notify = require("notify")' })
	-- use 'metakirby6/codi.vim'
	use({ "michaelb/sniprun", run = "bash ./install.sh" })
	if install_plugins then
		require("packer").sync()
	end
end)

if install_plugins then
	return
end

--settings
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= "o" then
		scopes["o"][key] = value
	end
end

local indent = 2
opt("b", "expandtab", false) -- Use tabs instead of spaces
opt("b", "shiftwidth", indent) -- Size of an indent
opt("b", "smartindent", true) -- Insert indents automatically
opt("b", "tabstop", indent) -- Number of spaces tabs count for
opt("o", "completeopt", "menu,menuone,noselect") -- Completion options
opt("o", "hidden", true) -- Enable modified buffers in background
opt("o", "scrolloff", 4) -- Lines of context
opt("o", "shiftround", true) -- Round indent
opt("o", "sidescrolloff", 9) -- Columns of context
opt("o", "smartcase", true) -- Don't ignore case with capitals
opt("o", "splitbelow", true) -- Put new windows below current
opt("o", "splitright", true) -- Put new windows right of current
opt("o", "autowrite", true) -- Autowrite buffers or file
opt("o", "clipboard", "unnamed")
opt("o", "pumblend", 26)
opt("o", "shell", "/usr/bin/tmux")
opt("o", "softtabstop", indent)
opt("o", "swapfile", false)
opt("o", "background", "dark")
opt("o", "backup", false)
opt("w", "number", true) -- Print line number
opt("o", "lazyredraw", false)
opt("o", "signcolumn", "yes")
opt("o", "mouse", "a")
opt("o", "cmdheight", 2)
opt("o", "guifont", "Fira Code iScript:h10.6") -- Download this font package and install from https://github.com/kencrocken/FiraCodeiScript
opt("o", "wrap", false)
opt("o", "relativenumber", true)
opt("o", "hlsearch", true)
opt("o", "inccommand", "split")
opt("o", "smarttab", true)
opt("o", "incsearch", true)
opt("o", "foldmethod", "manual")
opt("o", "breakindent", true)
opt("o", "lbr", true)
opt("o", "formatoptions", "l")
opt("o", "laststatus", 3)
opt("o", "cursorline", true)
opt("o", "cursorcolumn", false)
opt("o", "autoindent", true)
opt("o", "list", true)
opt("o", "timeoutlen", 500)
opt("o", "ttimeoutlen", 11)
opt("o", "updatetime", 300)
opt("o", "scrolljump", 16)
opt("o", "undofile", true)
--[[ opt('o', 't_ZH', 'e[3m') -- Italic support
opt('o', 't_ZR', 'e[23m') -- Italic support ]]

-- Fix CursorHold issue with the below updatetime
g.cursorhold_updatetime = 300

-- More options for listchars.
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

nvim_exec(
	[[
command! -nargs=1 Dap :lua require("dapui").toggle()
]],
	false
)

--mappings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	remap(mode, lhs, rhs, options)
end

g.did_load_filetypes = 2
g.mapleader = " " --leader
g.maplocalleader = ","
map("i", "jk", "<esc>") --jk to exit
map("c", "jk", "<C-C>")
map("n", ";", ":") --semicolon to enter command mode
map("n", "j", "gj") --move by visual line not actual line
map("n", "k", "gk")
map("n", "q", "<cmd>q<CR>")
map("n", "Q", "<cmd>qa<CR>")
map("n", "<leader>js", "<cmd>set filetype=javascript<CR>") -- for unknown extensions for js files
map("n", "<leader>hw", "<cmd>HopWord<CR>") --easymotion/hop
map("n", "<leader>hl", "<cmd>HopLine<CR>")
map("n", "<leader>/", "<cmd>HopPattern<CR>")
map("n", "<leader>fa", "<cmd>Telescope git_commits<CR>") -- git commits
map("n", "<leader>fg", "<cmd>Telescope git_bcommits<CR>") -- lists buffer's git commits with diff preview and checks them out on <cr>
map("n", "<leader>ft", "<cmd>Telescope git_status<CR>") -- lists current changes per file with diff preview and add action.
map("n", "<leader>fl", "<cmd>Telescope git_branches<CR>") -- lists all branches with log preview, checkout action <cr>, track action <C-t> and rebase action <C-r>
map("n", "<leader>fh", "<cmd>Telescope git_stash<CR>") -- lists stash items in current repository with ability to apply them on <cr>
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>") --fuzzy
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fs", "<cmd>Telescope treesitter<CR>")
map("n", "<leader>fc", "<cmd>Telescope commands<CR>")
map("n", "<leader>fm", "<cmd>Telescope marks<CR>")
map("n", "<leader>fe", "<cmd>Telescope emoji<CR>")
map("n", "[fo", "<cmd>foldopen<CR>")
map("n", "[fc", "<cmd>foldclose<CR>")
map("n", "[fl", "<cmd>fold<CR>")
map("n", "<c-g>", ":Glow<CR>")
map("n", "<leader>h", ":FocusSplitLeft<CR>", { silent = true })
map("n", "<leader>j", ":FocusSplitDown<CR>", { silent = true })
map("n", "<leader>k", ":FocusSplitUp<CR>", { silent = true })
map("n", "<leader>l", ":FocusSplitRight<CR>", { silent = true })
map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>") --nvimtree
map("n", "<leader>ss", "<cmd>SaveSession .sessions<CR>")
map("n", "<leader>sh", "<cmd>Telescope session-lens search_session<CR>")
map("n", "<leader>sr", "<cmd>RestoreSession .sessions<CR>")
map("n", "<leader>sd", "<cmd>DeleteSession .sessions<CR>")
map("n", "<leader>sl", "<cmd>SessionLoad .sessions<CR>")
map("t", "<leader>o", "<cmd>Vista<CR>") --fuzzN
map("n", "<c-k>", "<cmd>wincmd k<CR>") --ctrlhjkl to navigate splits
map("n", "<c-j>", "<cmd>wincmd j<CR>")
map("n", "<c-h>", "<cmd>wincmd h<CR>")
map("n", "<c-l>", "<cmd>wincmd l<CR>")
map("n", "<c-s>", "<cmd>w!<CR>")
map("n", "<c-x>", "<cmd>bdelete<CR>")
map("n", "<leader>b", "<cmd>BufferLinePick<CR>")
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>")
map("n", "<leader>bj", "<cmd>bprevious<CR>")
map("n", "<leader>bn", "<cmd>bnext<CR>")
map("n", "<leader>be", "<cmd>tabedit<CR>")
map("n", "<leader>ga", "<cmd>Gina add .<CR>")
map("n", "<leader>gm", "<cmd>Gina commit<CR>")
map("n", "<leader>gs", "<cmd>Gina status<CR>")
map("n", "<leader>gl", "<cmd>Gina pull<CR>")
map("n", "<leader>gu", "<cmd>Gina push<CR>")
map("n", "<leader>tq", "<cmd>TroubleToggle<CR>")
map("n", "<silent> <F5>", ":call LanguageClient#textDocument_hover()<CR>")
map("n", "<silent> <F4>", ":call LanguageClient#textDocument_codeAction()<CR>")
map("n", "<silent> <F6>", ":Bracey<CR>", { silent = true })
map("n", "<silent> <F7>", ":BraceyStop<CR>", { silent = true })
map("n", "<silent> <F8>", ":BraceyRelaod<CR>", { silent = true })
--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>", { silent = true })
-- Open nvimrc file
map("n", "<leader>v", "<cmd>e $MYVIMRC<CR>")
-- Source nvimrc file
map("n", "<leader>sv", "<cmd>:source ~/.config/nvim/init.lua<CR>")
-- map("n", "<leader>sv", "<cmd>:luafile %<CR>")
-- Easy select all of file
map("n", "<C-a>", "ggVG<c-$>")
-- Line bubbling
map("n", "<S-A-j>", "<cmd>m .+1<CR>==", { silent = true })
map("n", "<S-A-k>", "<cmd>m .-2<CR>==", { silent = true })
map("v", "<S-A-k>", ":m '<-2<CR>==gv=gv", { silent = true })
map("v", "<S-A-j>", ":m '>+1<CR>==gv=gv", { silent = true })
-- Split screen
-- map("n", "sh", ":split<CR>", { silent = true }) -- Split horizontally
-- map("n", "sv", ":vsplit<CR>", { silent = true }) -- Split vertically
-- cmd [[autocmd FocusLost * :wa]] -- Autosave buffer files on focus lost
-- cmd [[autocmd CursorHold,CursorHoldI * update]] -- Autosave buffer files after every edit
cmd([[autocmd BufWritePre * %s/\s\+$//e]]) --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])
cmd([[autocmd BufRead * ColorizerAttachToBuffer]]) -- Attach colorizer to all buffers
cmd([[autocmd BufRead *.rsh set filetype=reach]])
-- Open in last edit place
cmd([[ autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif ]])

-- Live compile sass files
cmd([[autocmd bufwritepost [^_]*.sass,[^_]*.scss  silent exec "!sass %:p %:r.css"]])

-- cmd [[autocmd Filetype reach set syntax=javascript]]
cmd([[autocmd BufRead *.rsh set syntax=javascript]])
cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
cmd(
	[[autocmd FileChangedShellPost * call v:lua.vim.notify("File changed on disk. Buffer reloaded!", 'warn', {'title': 'File Notify', 'timeout': 1001})]]
)
cmd([[highlight IndentBlanklineIndent2 guifg=#E06C75 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent3 guifg=#E5C07B gui=nocombine]])
cmd([[highlight IndentBlanklineIndent4 guifg=#98C379 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent5 guifg=#56B6C2 gui=nocombine]])
cmd([[highlight IndentBlanklineIndent6 guifg=#61AFEF gui=nocombine]])
cmd([[highlight IndentBlanklineIndent7 guifg=#C678DD gui=nocombine]])

-- Enable italics font for some neovim highlights. Please feel free to enable all you want but it might make your ide look odd
cmd([[autocmd ColorScheme zephyr highlight Keyword gui=italic cterm=italic]]) -- set for all Keywords
cmd([[autocmd ColorScheme zephyr highlight Comment gui=italic cterm=italic]]) -- set for all Comments
-- cmd [[autocmd ColorScheme zephyr highlight Function gui=italic cterm=italic]] -- set for all Functions
-- cmd [[autocmd ColorScheme zephyr highlight Constant gui=italic cterm=italic]] -- set for all Constants
cmd([[autocmd ColorScheme zephyr highlight Exception gui=italic cterm=italic]]) -- set for all Exception
cmd([[autocmd ColorScheme zephyr highlight Type gui=italic cterm=italic]]) -- set for all Type
cmd([[autocmd ColorScheme zephyr highlight Label gui=italic cterm=italic]]) -- set for all Label
-- cmd [[autocmd ColorScheme zephyr highlight Include gui=italic cterm=italic]] -- set for all Include
-- cmd [[autocmd ColorScheme zephyr highlight StorageClass gui=italic cterm=italic]] -- set for all StorageClass
-- cmd [[autocmd ColorScheme zephyr highlight Structure gui=italic cterm=italic]] -- set for all Structure
-- cmd [[autocmd ColorScheme zephyr highlight Typedef gui=italic cterm=italic]] -- set for all Typedefinitions
cmd([[autocmd ColorScheme zephyr highlight SpecialComment gui=italic cterm=italic]]) -- set for all Special things n a comment
cmd([[autocmd ColorScheme zephyr highlight PreProc gui=italic cterm=italic]]) -- set for all generic PreProcessors

local numbers =
{ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "13", "14", "15", "16", "17", "18", "19", "20" }
for _, num in pairs(numbers) do
	map("n", "<leader>" .. num, "<cmd>BufferLineGoToBuffer " .. num .. "<CR>")
end

-- Configuring for Reach Intellisense
nvim_exec(
	[[
  let g:LanguageClient_serverCommands = {'reach': ['node', '~/.local/share/nvim/site/reach-ide/server/out/server.js', '--stdio']}
  let g:LanguageClient_loggingLevel = 'DEBUG'
  let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/site/reach-ide/reach-language-client.log')
  let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/site/reach-ide/reach-language-server.log')
]],
	false
)

nvim_exec(
	[[
  let g:VM_maps = {}
  let g:VM_default_mappings = 1
  let g:VM_maps["Add Cursor Down"] = '<A-j>'
  let g:VM_maps["Add Cursor Up"] = '<A-k>'
  let g:indent_blankline_char_highlight_list = ['|', '¦', '┆', '┊']
  let g:indent_blankline_filetype_exclude = ['help', 'dashboard', 'NvimTree', 'telescope', 'packer']
]],
	false
)

-- Omnisharp configuration
nvim_exec(
	[[
  let g:Omnisharp_server_studio = 2
  let g:OmniSharp_selector_ui = 'fzf'
  let g:OmniSharp_selector_findusages = 'fzf'
  let g:OmniSharp_highlighting = 4
]],
	false
)

require("telescope").load_extension("emoji")

-- Allowing transparent neovim
--[[ require("transparent").setup({
	enable = false, -- boolean: enable transparent
	extra_groups = { -- table/string: additional groups that should be cleared
		-- In particular, when you set it to 'all', that means all available groups

		-- example of akinsho/nvim-bufferline.lua
		"BufferLineTabClose",
		"BufferlineBufferSelected",
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineSeparator",
		"BufferLineIndicatorSelected",
	},
	exclude = {}, -- table: groups you don't want to clear
}) ]]

require("jc").setup({}) -- Java support

require("bufferline").setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = function(opts)
			return string.format("%s", opts.raise(opts.ordinal))
			-- return string.format('%s.%s', opts.ordinal, opts.raise(opts.id))
		end,
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon",
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match("%.md") then
				return vim.fn.fnamemodify(buf.name, ":t:r")
			end
		end,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
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
		offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } }, -- this allows for splits not to have bufferlines in them
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
		sort_by = "insert_at_end", -- 'insert_at_end' | 'insert_after_current' | 'id' | 'extension' | 'relative_directory'
		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
				local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

				-- Was commented to have a clear bufferline background when transparent mode is active.
				if error ~= 0 then
					table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
				end

				if warning ~= 0 then
					table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
				end

				if hint ~= 0 then
					table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
				end

				if info ~= 0 then
					table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
				end
				return result
			end,
		},
	},
})

require("guihua.maps").setup({
	maps = {
		close_view = "q",
	},
})

-- focus screen-autoresizer
require("focus").setup({ hybridnumber = true })

-- scrollbar
nvim_exec(
	[[
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end
]],
	false
)

g.vista_default_executive = "nvim_lsp"

require("indent_blankline").setup({
	buftype_exclude = { "terminal", "telescope", "nvim-tree" },
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
})

--theme
cmd("colorscheme zephyr")
-- Get zephyr color
require("zephyr")
-- local zephyr =  require('zephyr').zephyr.yellow/teal/fg/bg
-- cmd 'colorscheme nightfly'

local notify = require("notify")
--[[ notify.setup({
	background_colour = "#000000",
}) ]]

-- lightspeed config
require("lightspeed").setup({
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
})

require("hlslens").setup({
	auto_enable = true,
	enable_incsearch = true,
	calm_down = true,
	nearest_only = true,
	nearest_float_when = "always",
	override_lens = function(render, posList, nearest, idx, relIdx)
		local sfw = vim.v.searchforward == 2
		local indicator, text, chunks
		local absRelIdx = math.abs(relIdx)
		if absRelIdx > 2 then
			indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 2) and "▲" or "▼")
		elseif absRelIdx == 2 then
			indicator = sfw ~= (relIdx == 2) and "▲" or "▼"
		else
			indicator = ""
		end

		local lnum, col = unpack(posList[idx])
		if nearest then
			local cnt = #posList
			if indicator ~= "" then
				text = ("[%s %d/%d]"):format(indicator, idx, cnt)
			else
				text = ("[%d/%d]"):format(idx, cnt)
			end
			chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
		else
			text = ("[%s %d]"):format(indicator, idx)
			chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
		end
		render.setVirt(1, lnum - 1, col - 1, chunks, nearest)
	end,
})

-- telescope media renderer
require("telescope").load_extension("media_files")

--nvim treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	context_commentstring = { enable = true },
	highlight = { enable = true },
	rainbow = { enable = true, extended_mode = true },
	indent = { enable = true },
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
			"xml",
		},
	},
	refactor = { highlight_definitions = { enable = true } },
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
			border = "none",
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
})

local cmp = require("cmp")

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noselect",
	},
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
			require("luasnip").lsp_expand(args.body) -- For luasnip users
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-3),
		["<C-t>"] = cmp.mapping.scroll_docs(5),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnp" },
		{ name = "cmp_tabnine" },
		{ name = "buffer" },
		{ name = "treesitter" },
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "spell" },
	},
	-- File types specifics
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" },
		}, {
			{ name = "buffer" },
		}),
	}),

	-- Command line completion
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { { name = "buffer" } },
	}),

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
			vim_item.menu = ({
				path = "   [Path]",
				buffer = "   [Buffer]",
				nvim_lsp = "   [LSP]",
				vsnip = "   [luasnip]",
				treesitter = "   [Ts]",
				calc = "   [Calc]",
				spell = "   [Spell]",
				emoji = " ﲃ  [Emoji]",
				cmp_tabnine = "⦿   [Tn]",
			})[entry.source.name]
			return vim_item
		end,
	},
	experimental = {
		ghost_text = true,
	},
})

-- Lspsaga
-- require("lspsaga").setup{}
-- Lspsaga timed hover
--[[ local show_timed_hover = function()
	vim.fn.timer_start(100, '<cmd>Lspsaga hover_doc<CR>')
end ]]

-- Tried yet another approach
-- vim.lsp.buf.CursorHold('<cmd>Lspsaga hover_doc<CR>', 500)

-- cmd[[autocmd CursorHold * lua require('lspsaga.hover').render_hover_doc()]]
-- cmd[[autocmd CursorHoldI * lua require('lspsaga.hover').render_hover_doc()]]
-- cmd[[ autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false }) ]] -- This didn't work either

-- Call up servers on launch
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- require("lspconfig").pylsp.setup{} -- necessary to enforce pylsp globally
local servers =
{ "cssls", "html", "rust_analyzer", "tsserver", "graphql", "volar", "jsonls", "dockerls", "tailwindcss" }
local nvim_lsp = require("lspconfig")
for _, server in pairs(servers) do
	nvim_lsp[server].setup({
		on_attach = function(client, bufnr)
			vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
			client.server_capabilities.document_formatting = false
		end,
		capabilities = capabilities,
		init_options = {
			onlyAnalyzeProjectsWithOpenFiles = true,
			sugggestFromUnimportedLibraries = true,
			closingLabels = true,
		},
	})
end

-- luasnip setup
local luasnip = require("luasnip")

-- Signature help
require("lsp_signature").on_attach()

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 	vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = {
-- 		prefix = "",
-- 		spacing = 1,
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = true,
-- }
-- )

local on_attach = function(client)
	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

	require("lspsaga")

	vim.keymap.set("n", "[f", "<cmd>Lspsaga lsp_finder<CR>", opts)

	-- code action
	vim.keymap.set("n", "[a", "<cmd>Lspsaga code_action<CR>", opts)
	-- range code action
	vim.keymap.set("v", "[a", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)

	-- show hover doc and press twice will jump to hover window
	vim.keymap.set("n", "[o", "<cmd>Lspsaga hover_doc<CR>", opts)

	-- show signature help
	vim.keymap.set("n", "[s", "<cmd>Lspsaga signature_help<CR>", opts)

	-- toggle code outline
	vim.keymap.set("n", "[t", "<cmd>LSoutlineToggle<CR>", opts)

	-- rename
	vim.keymap.set("n", "[n", "<cmd>Lspsaga rename<CR>", opts)

	-- preview definition
	vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
	-- show line and cursor diagnostics
	vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

	-- jump to next diagnostic
	vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	-- jump to previous diagnostic
	vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	-- jump to previous error diagnostic
	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	-- jump to next error diagnostic
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, opts)

	-- float terminal
	-- open the float terminal
	vim.keymap.set("n", "<leader>tt", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	vim.keymap.set("n", "[g", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
	-- close the float terminal
	vim.keymap.set("t", "<C-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

	if client.server_capabilities.document_formatting then
		vim.keymap.set("n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
	if client.server_capabilities.document_range_formatting then
		vim.keymap.set("v", "<space>fo", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
	--------------------
	-- KNAP functions --
	--------------------
	-- F3 processes the document once, and refreshes the view
	--[[ vim.keymap.set('i', '<F3>', function() require("knap").process_once() end, opts)
	vim.keymap.set('v', '<F3>', function() require("knap").process_once() end, opts)
	vim.keymap.set('n', '<F3>', function() require("knap").process_once() end, opts) ]]

	-- F6 closes the viewer application, and allows settings to be reset
	--[[ vim.keymap.set('i', '<F6>', function() require("knap").close_viewer() end, opts)
	vim.keymap.set('v', '<F6>', function() require("knap").close_viewer() end, opts)
	vim.keymap.set('n', '<F6>', function() require("knap").close_viewer() end, opts) ]]

	-- F7 toggles the auto-processing on and off
	--[[ vim.keymap.set('i', '<F7>', function() require("knap").toggle_autopreviewing() end, opts)
	vim.keymap.set('v', '<F7>', function() require("knap").toggle_autopreviewing() end, opts)
	vim.keymap.set('n', '<F7>', function() require("knap").toggle_autopreviewing() end, opts) ]]

	-- F8 invokes a SyncTeX forward search, or similar, where appropriate
	--[[ vim.keymap.set('i', '<F8>', function() require("knap").forward_jump() end, opts)
	vim.keymap.set('v', '<F8>', function() require("knap").forward_jump() end, opts)
	vim.keymap.set('n', '<F8>', function() require("knap").forward_jump() end, opts) ]]

	local msg = string.format("Language server %s started!", client.name)
	notify(msg, "info", { title = "LSP Notify", timeout = 1001 })
end

-- npm install --global vls @volar/server @johnsoncodehk/html2pug @volar/pug-language-service @volar/vue-language-server @volar/typescript-language-service @volar/vue-language-service typescript typescript-language-server graphql-language-service-cli dockerfile-language-server-nodejs stylelint-lsp yaml-language-server prettier
-- can use rls or rust_analyzer

require("nvim-lsp-installer").setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "use", "on_attach" },
			},
		},
	},
})

-- vim.lsp.set_log_level("debug")
require("trouble").setup({})
require("lspkind").init({
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol",
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = "codicons",
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
		TypeParameter = "",
	},
	-- finder icons
	finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	},
	-- finder do lsp request timeout
	-- if your project big enough or your server very slow
	-- you may need to increase this value
	finder_request_timeout = 1500,
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		tabe = "t",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>", -- quit can be a table
	},
})
require("diffview").setup({})
require("nvim-autopairs").setup({})

local gps = require("nvim-gps")
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{ "filename" },
			{
				gps.get_location,
				cond = gps.is_available,
				color = { fg = "#f3ca28" },
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

--colorizer
require("colorizer").setup({
	DEFAULT_OPTIONS = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = true, -- "Name" codes like Blue
		RRGGBBAA = true, -- #RRGGBBAA hex codes
		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions
		css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes: foreground, background
		mode = "background", -- Set the display mode.
	},
})

require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = false,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_reload_on_write = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 501,
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	view = {
		width = 31,
		side = "left",
		hide_root_folder = false,
		number = false,
		relativenumber = true,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
})

--gitsigns
require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	numhl = true,
	linehl = false,
	signcolumn = true,
	word_diff = false,
	watch_gitdir = {
		interval = 500,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right-align'
		delay = 500,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	diff_opts = {
		internal = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hS", gs.stage_buffer)
		map("n", "<leader>hu", gs.undo_stage_hunk)
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end)
		map("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

--[[ fn.sign_define(
	"LspDiagnosticsSignError",
	{ texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
)
fn.sign_define(
	"LspDiagnosticsSignWarning",
	{ texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
)
fn.sign_define(
	"LspDiagnosticsSignHint",
	{ texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
)
fn.sign_define(
	"LspDiagnosticsSignInformation",
	{ texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
) ]]

g.dashboard_disable_statusline = 1
g.dashboard_session_directory = vim.fn.stdpath("data") .. "/sessions"
g.dashboard_default_executive = "telescope"

if vim.fn.has("win33") == 1 then
	cmd("let packages = len(globpath('~/AppData/Local/nvim-data/site/pack/packer/start', '*', 1, 1))")
else
	cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 1, 1))")
end

nvim_exec(
	[[
	let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' packages']
]],
	false
)

g.dashboard_custom_section = {
	a = { description = { "🔎  Find File                 SPC f f" }, command = "Telescope find_files" },
	b = { description = { "   Recents                   SPC f r" }, command = "Telescope oldfiles" },
	c = { description = { "   Find Word                 SPC f w" }, command = "Telescope live_grep" },
	d = { description = { "洛  New File                  SPC f n" }, command = "DashboardNewFile" },
	e = { description = { "   Bookmarks                 SPC f m" }, command = "Telescope marks" },
	f = { description = { "   Load Last Session         SPC s l" }, command = "SessionLoad" },
}

---------------------------------
-- Formatting
---------------------------------
-- local diagnostics = require("null-ls").builtins.diagnostics
-- local formatting = require("null-ls").builtins.formatting
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- require("null-ls").setup({
-- 	sources = {
-- 		formatting.black,
-- 		formatting.rustfmt,
-- 		formatting.phpcsfixer,
-- 		formatting.prettier,
-- 		formatting.stylua,
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
-- 			client.resolved_capabilities.document_formatting = false
-- 		end

-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				callback = function()
-- 					vim.lsp.buf.formatting_sync()
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })

---------------------------------
-- Auto commands
---------------------------------
vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])

local prettier = require("prettier")
prettier.setup({
	bin = "prettier", -- or `prettierd`
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
		"lua",
		"rust",
	},

	-- prettier format options (you can use config files too. ex: `.prettierrc`)
	arrow_parens = "always",
	bracket_spacing = true,
	embedded_language_formatting = "auto",
	end_of_line = "lf",
	html_whitespace_sensitivity = "css",
	jsx_bracket_same_line = false,
	jsx_single_quote = true,
	print_width = 80,
	prose_wrap = "preserve",
	quote_props = "as-needed",
	semi = true,
	single_quote = true,
	tab_width = 2,
	trailing_comma = "es7",
	use_tabs = false,
	vue_indent_script_and_style = false,
})

require("which-key").setup({})

require("todo-comments").setup({
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
})
