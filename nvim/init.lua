
-------------------------------------------------
-- BASIC CONFIGURATION
-------------------------------------------------
local g = vim.g
local o = vim.o
local cmd = vim.cmd
local opt = vim.opt

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

cmd('syntax on')
vim.api.nvim_command('filetype plugin indent on')
opt.shortmess:append "c"

-- scheme
o.termguicolors = true
cmd("colorscheme mac_classic")
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 300
o.updatetime = 300

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.encoding="utf-8"
o.numberwidth = 2
o.relativenumber = false
o.signcolumn = "yes"
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'
o.errorbells = false

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Enable autocompletion
o.wildmode = "longest,list:longest,full"

-- Preserve view while jumping
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--
opt.mouse = "a"



require('core/autocmds')
-------------------------------------------------
-- PLUGIN CONFIGURATION
-------------------------------------------------
-- lualine
require('core/statuslines')

-- completion / cmp
require('core/cmps')

-- LuaSnip
require('core/luasnips')

-- NvimTree
require('core/trees')

-- TreeSitter
require('core/treesitters')
-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

local opts = { noremap = true, silent = true }

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Load recent sessions
map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

-- maps for go down and up 
map("n", "j", "gj")
map("n", "k", "gk")

-- maps for  spellcheck
map("n", "<leader>o" , ":setlocal spell! spelllang=id<CR>")

map("n", "<F7>" , ":setlocal spell! spelllang=en_us<CR>")

-- maps split navigation
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- map buffer
map("n", "<c-b>", ":ls<CR>:b<Space>", opts )
map("n", "<leader>h", ":bprevious<CR>", opts )
map("n", "<leader>l", ":bnext<CR>", opts )

-- nvim-tree
map("n", "<leader>e", require("nvim-tree.api").tree.toggle)

-------------------------------------------------
-- PLUGINS
-------------------------------------------------

local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Dashboard is a nice start screen for nvim
	use("glepnir/dashboard-nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-file-browser.nvim")

	use("nvim-treesitter/nvim-treesitter") -- Treesitter Syntax Highlighting


	-- Completion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("uga-rosa/cmp-dictionary")
    use("saadparwaiz1/cmp_luasnip") 

    -- Snippet
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

	-- Productivity
	use("vimwiki/vimwiki")
	use("jreybert/vimagit")
	use("nvim-orgmode/orgmode")

	use("folke/which-key.nvim") -- Which Key
	use("nvim-lualine/lualine.nvim") -- A better statusline

	-- File management --
    use("nvim-tree/nvim-tree.lua")
	use("vifm/vifm.vim")
	use("ryanoasis/vim-devicons")

	-- Tim Pope Plugins --
	use("tpope/vim-surround")

	-- Syntax Highlighting and Colors --
	use("PotatoesMaster/i3-vim-syntax")
	use("kovetskiy/sxhkd-vim")
	use("vim-python/python-syntax")
	use("ap/vim-css-color")
	use("nickeb96/fish.vim")

	-- Junegunn Choi Plugins --
	use("junegunn/vim-emoji")

	-- Colorschemes --
    
	-- Other stuff --
    use("p00f/nvim-ts-rainbow")

    -- Scientist
    use("lervag/vimtex")
    use("Konfekt/FastFold")

	if packer_bootstrap then
		packer.sync()
	end
end)
