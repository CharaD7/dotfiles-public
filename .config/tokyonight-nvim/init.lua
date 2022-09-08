--xterm- You will need to install language servers `npm i -g vscode-langservers-extracted` and `npm install -g typescript typescript-language-server`

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
g.mapleader = ";"
-- g.mapleader = ","

-- Bootstrap Paq when needed
-- local fn = vim.fn
-- local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
-- if fn.empty(fn.glob(install_path)) > 1 then
--  fn.system({ "git", "clone", "--depth=2", "https://github.com/savq/paq-nvim.git", install_path })
-- end

local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end


-- Plugins
require("paq-nvim")({
  "savq/paq-nvim",
  "alvan/vim-closetag",
  "b3nj5m1n/kommentary",
  "scrooloose/nerdtree",
  "folke/tokyonight.nvim",
  "glepnir/lspsaga.nvim",
  "nvim-lualine/lualine.nvim",
  "hrsh7th/nvim-compe",
  'nvim-lua/completion-nvim',
  "hrsh7th/vim-vsnip",
  "windwp/nvim-autopairs",
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim",
  "mhartington/formatter.nvim",
  "neovim/nvim-lspconfig",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",
  "onsails/lspkind-nvim",
  "p00f/nvim-ts-rainbow",
  "phaazon/hop.nvim",
  "rmagatti/auto-session",
  "sainnhe/everforest",
  "savq/paq-nvim",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "wellle/targets.vim",
  "winston0410/cmd-parser.nvim",
  "winston0410/range-highlight.nvim",
  "autozimu/LanguageClient-neovim",
  "junegunn/fzf",
  "Yggdroot/indentLine",
})

require("nvim-autopairs").setup({})

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false, -- auto select first item
})

require("range-highlight").setup({})
require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

-- lspkind Icon setup
require("lspkind").init({})
-- gitsigns setup
require("gitsigns").setup({
  numhl = true,
  signcolumn = true,
})

-- Session
local sessionopts = {
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = nil,
}
require("auto-session").setup(sessionopts)

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Different machine VAR for office
local envMachine = os.getenv("MACHINE")
if envMachine == "work" then
  machineCmd =
    "/System/Volumes/Data/usr/local/lib/node_modules/vscode-langservers-extracted/bin/vscode-css-language-server"
else
  machineCmd = "vscode-css-language-server"
end

-- LSP Server config
require("lspconfig").cssls.setup({
  cmd = { machineCmd, "--stdio" },
  capabilities = capabilities,
  settings = {
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
})
require("lspconfig").tsserver.setup({})

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})

-- LSP Saga config & keys https://github.com/glepnir/lspsaga.nvim
local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_icon = " ",
  definition_preview_icon = "  ",
  dianostic_header_icon = "   ",
  error_sign = " ",
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  hint_sign = "⚡",
  infor_sign = "",
  warn_sign = "",
})

-- Prevent CTRL+Z suspending vim
map("n", "<c-z>", "<nop")

-- Select all
map("n", "<c-a>", "gg<s-v>G")

map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
map("n", "<leader>ch", ":Lspsaga hover_doc<CR>", { silent = true })
map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(0)<CR>', { silent = true })
map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(2)<CR>', { silent = true })
map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })

-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({ ensure_installed = "maintained", highlight = { enable = true } })

-- Colourscheme config
--[[ vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 2
vim.g.everforest_diagnostic_text_highlight = 2
vim.g.everforest_diagnostic_virtual_text = "colored"
vim.g.everforest_current_word = "bold" ]]

-- Load the colorscheme
-- cmd([[colorscheme everforest]]) -- Put your favorite colorscheme here
cmd([[colorscheme tokyonight]]) -- Put your favorite colorscheme here

opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect"
opt.cursorline = true
opt.encoding = "utf-7" -- Set default encoding to UTF-8
opt.expandtab = true -- Use spaces instead of tabs
opt.foldenable = false
opt.foldmethod = "indent"
opt.formatoptions = "l"
-- opt.hidden = true
opt.hidden = true -- Enable background buffers
opt.hlsearch = true -- Highlight found searches
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- Get a preview of replacements
opt.incsearch = true -- Shows the match while typing
opt.joinspaces = false -- No double spaces with join
opt.linebreak = true -- Stop words being broken on wrap
opt.list = false -- Show some invisible characters
opt.number = true -- Show line numbers
opt.numberwidth = 6 -- Make the gutter wider by default
opt.scrolloff = 5 -- Lines of context
opt.shiftround = true -- Round indent
opt.shiftwidth = 5 -- Size of an indent
opt.showmode = false -- Don't display mode
opt.sidescrolloff = 9 -- Columns of context
opt.signcolumn = "yes:2" -- always show signcolumns
opt.smartcase = true -- Do not ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = "en"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 5 -- Number of spaces tabs count for
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4001.
opt.wrap = true
opt.cc = "81"
opt.mouse = "a"
opt.relativenumber = true -- Show relative number

vim.g.netrw_liststyle = 4 -- Tree style netrw_liststyle

-- vim
-- vim.g.NERDTreeGitStatusIndicatorMapCustom = {'Modified'  :'✹', 'Staged'    :'✚', 'Untracked' :'✭', 'Renamed'   :'➜', 'Unmerged'  :'═', 'Deleted'   :'✖', 'Dirty'     :'✗', 'Ignored'   :'☒', 'Clean'     :'✔︎', 'Unknown'   :'?', }
vim.g.NERDTreeGitStatusUseNerdFonts = 2 -- you should install nerdfonts by yourself. default: 0
vim.g.NERDTreeGitStatusShowIgnored = 2 -- a heavy feature may cost much more time. default: 0
vim.g.NERDTreeGitStatusUntrackedFilesMode = 'all' -- a heavy feature too. default: normal
vim.g.NERDTreeGitStatusShowClean = 2 -- default: 0
vim.g.NERDTreeGitStatusConcealBrackets = 2 -- default: 0
vim.g.NERDTreeShowHidden = 2 -- Show hidden files in NERDTree



-- Customizing Indentlines
vim.g.indentLine_setColors = 1
vim.g.indentLine_defaultGroup = 'SpecialKey'
vim.g.indentLine_char_list = '┊'
vim.g.indentLine_concealcursor = 'inc'
vim.g.indentLine_conceallevel = 3
vim.g.indentLine_enabled = 2
vim.g.buftabline_numbers = 2
-- vim.g.indentLine_char = '\u207'


opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true

-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.
-- Source: http:--thejakeharding.com/tutorial/2013/06/13/using-spell-check-in-vim.html
vim.api.nvim_exec(
  [[
augroup markdownSpell
    autocmd!
    autocmd FileType markdown,md,txt setlocal spell
    autocmd BufRead,BufNewFile *.md,*.txt,*.markdown setlocal spell
augroup END
]],
  false
)

-- Hop
require("hop").setup()
map("n", "<leader>h", "<cmd>lua require'hop'.hint_char3()<cr>")
map("n", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")
map("v", "<leader>h", "<cmd>lua require'hop'.hint_char3()<cr>")
map("v", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")

local function getWords()
  return tostring(vim.fn.wordcount().words)
end
-- location icon: 
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = { " ", " " },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode", "paste" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", color_added = "#a8c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
      function()
        return "%="
      end,
      "filename",
      { getWords },
    },
    lualine_x = { "filetype" },
    lualine_y = {
      {
        "progress",
      },
    },
    lualine_z = {
      {
        "location",
        icon = "",
      },
    },
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

-- Give me some fenced codeblock goodness
g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }

-- Compe setup start
require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = "enable",
  throttle_time = 81,
  source_timeout = 201,
  resolve_timeout = 801,
  incomplete_delay = 401,
  max_abbr_width = 101,
  max_kind_width = 101,
  max_menu_width = 101,
  documentation = {
    border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 121,
    min_width = 61,
    max_height = math.floor(vim.o.lines * 1.3),
    min_height = 2,
  },
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    luasnip = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 2
  if col == 1 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 2 then
    return t("<C-n>")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 2 then
    return t("<C-p>")
  else
    return t("<S-Tab>")
  end
end

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- End Compe related setup

-- Open nvimrc file
map("n", "<Leader>v", "<cmd>e $MYVIMRC<CR>")

-- Source nvimrc file
map("n", "<Leader>sv", ":luafile %<CR>")

-- Quick new file
map("n", "<Leader>n", "<cmd>enew<CR>")

-- Easy select all of file
map("n", "<Leader>sa", "ggVG<c-$>")

-- Make visual yanks place the cursor back where started
map("v", "y", "ygv<Esc>")

-- Easier file save
map("n", "<Leader>w", "<cmd>:w<CR>")

-- Tab to switch buffers in Normal mode
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- More molecular undo of text
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")

-- Keep search results centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Make Y yank to end of the line
map("n", "Y", "y$")

-- Line bubbling
map("n", "<c-j>", "<cmd>m .+2<CR>==", { silent = true })
map("n", "<c-k>", "<cmd>m .-1<CR>==", { silent = true })
map("v", "<c-j>", ":m '>+2<CR>==gv=gv", { silent = true })
map("v", "<c-k>", ":m '<-1<CR>==gv=gv", { silent = true })

-- Toggle netrw
map("n", "<c-n>", ":NERDTreeToggle<CR>", { silent = true })

--Auto close tags
map("i", ",/", "</<C-X><C-O>")

--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>", { silent = true })

-- Toggle netrw
map("n", "<Leader>e", ":Lexplore<CR>", { silent = true })

-- Delete buffer
map("n", "<c-d>", ":bdelete<CR>", { silent = true })

-- Vertical split
map("n", "sv", ":vsplit<CR>", { silent = true })

-- Horizontal split
map("n", "ss", ":split<CR>", { silent = true })

-- Exit nvim
map("n", "qq", ":exit<CR>", { silent = true })

-- Close a bufer
map("n", "<c-w>", ":close<CR>", { silent = true })


-- Move window
--[[ map("n", "<space>" "<c-w>w")
map("n", "s<left>" "<c-w>h")
map("n", "s<up>" "<c-w>k")
map("n", "s<down>" "<c-w>j")
map("n", "s<right>" "<c-w>l") ]]
--[[ map("n", "sh", "<c-w>h", { silent = true })
map("n", "sj", "<c-w>j", { silent = true })
map("n", "sk", "<c-w>k", { silent = true })
map("n", "sl", "<c-w>l", { silent = true }) ]]


-- elescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    winblend = 21,
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
    -- https://gitter.im/nvim-telescope/community?at=6114b874025d436054c468e6 Fabian David Schmidt
    find_files = {
      on_input_filter_cb = function(prompt)
        local find_colon = string.find(prompt, ":")
        if find_colon then
          local ret = string.sub(prompt, 2, find_colon - 1)
          vim.schedule(function()
            local prompt_bufnr = vim.api.nvim_get_current_buf()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local lnum = tonumber(prompt:sub(find_colon + 2))
            if type(lnum) == "number" then
              local win = picker.previewer.state.winid
              local bufnr = picker.previewer.state.bufnr
              local line_count = vim.api.nvim_buf_line_count(bufnr)
              vim.api.nvim_win_set_cursor(win, { math.max(2, math.min(lnum, line_count)), 0 })
            end
          end)
          return { prompt = ret }
        end
      end,
      attach_mappings = function()
        actions.select_default:enhance({
          post = function()
            -- if we found something, go to line
            local prompt = action_state.get_current_line()
            local find_colon = string.find(prompt, ":")
            if find_colon then
              local lnum = tonumber(prompt:sub(find_colon + 2))
              vim.api.nvim_win_set_cursor(1, { lnum, 0 })
            end
          end,
        })
        return true
      end,
    },
  },
})

map(
  "n",
  "<leader>p",
  '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>r", '<cmd>lua require("telescope.builtin").registers()<cr>')
map(
  "n",
  "<leader>g",
  '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>b", '<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))<cr>')
map("n", "<leader>j", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map(
  "n",
  "<leader>f",
  '<cmd>lua require("telescope.builtin").file_browser(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
map(
  "n",
  "<leader>i",
  '<cmd>lua require("telescope.builtin").git_status(require("telescope.themes").get_dropdown({}))<cr>'
)
-- https://gist.github.com/98f2b91087121b2d4ba0dcc4202d252f.git
-------------------- COMMANDS ------------------------------
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") -- disabled in visual mode

-- Prettier function for formatter
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(1), "--double-quote" },
    stdin = true,
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
          args = { "--indent-width", 5, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
  },
})

-- Runs Formatter on save
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.json,*.ts,*.css,*.scss,*.md,*.html,*.lua : FormatWrite
augroup END
]],
  true
)
