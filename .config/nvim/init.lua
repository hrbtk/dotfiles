-- Leader key
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- General
vim.o.undofile       = false
vim.o.swapfile       = false
vim.o.compatible     = false -- turn off vi compatibility mode
vim.o.syntax         = "ON"
vim.o.backup         = false
vim.o.writebackup    = false
vim.o.mouse          = 'a'           -- enable the mouse in all modes
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- Appearence
vim.o.number         = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.splitbelow     = true -- Horizontal splits will be below
vim.o.splitright     = true -- Vertical splits will be to the right
vim.o.breakindent    = true -- Indent wrapped lines to match line start
vim.o.linebreak      = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.o.cursorline     = true -- Highlight current line

vim.o.showcmd        = true
vim.o.cmdheight      = 1

vim.o.ruler          = false   -- Don't show cursor position in command line
vim.o.wrap           = false   -- Display long lines as just one line
vim.o.showmode       = false   -- Don't show mode in command line

vim.o.signcolumn     = "yes"   -- Always show sign column (otherwise it will shift text)
vim.o.fillchars      = "eob: " -- Don't show `~` outside of buffer

vim.o.pumblend       = 10      -- Make builtin completion menus slightly transparent
vim.o.pumheight      = 10      -- Make popup menu smaller
vim.o.winblend       = 10      -- Make floating windows slightly transparent

vim.o.scrolloff      = 8       -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff  = 8       -- scroll page when cursor is 8 spaces from left/right

-- Editing
vim.o.ignorecase     = true    -- enable case insensitive searching
vim.o.incsearch      = true    -- enable incremental searching
vim.o.infercase      = true    -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase      = true    -- all searches are case insensitive unless there's a capital letter
vim.o.smartindent    = true    -- all searches are case insensitive unless there's a capital letter
vim.o.hlsearch       = true    -- disable all highlighted search results
vim.o.tabstop        = 4       -- tabs=4spaces
vim.o.shiftwidth     = 4
vim.o.fileencoding   = "utf-8" -- encoding set to utf-8
vim.o.clipboard      = "unnamedplus"

vim.o.completeopt    = 'menuone,noselect' -- Customize completions
vim.o.virtualedit    = 'block'            -- Allow going past the end of line in visual block mode
vim.o.formatoptions  = 'qjl1'             -- Don't autoformat comments


vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	-- { src = "https://github.com/echasnovski/mini.pick" },
	-- { src = "https://github.com/echasnovski/mini.basics" },
	-- { src = "https://github.com/echasnovski/mini.extra" },
	-- { src = "https://github.com/echasnovski/mini.completion" },
	-- { src = "https://github.com/echasnovski/mini.pairs" },
	-- { src = "https://github.com/echasnovski/mini.icons" },
	-- { src = "https://github.com/echasnovski/mini-git" },
	-- { src = "https://github.com/echasnovski/mini.diff" },
	-- { src = "https://github.com/echasnovski/mini.statusline" },
	-- { src = "https://github.com/echasnovski/mini.clue" },
	-- { src = "https://github.com/echasnovski/mini.surround" },
})

require "mini.pick".setup()
require "mini.extra".setup()
require "mini.completion".setup()
require "mini.pairs".setup()
require "mini.icons".setup()
require "mini.git".setup()
require "mini.diff".setup()
require "mini.statusline".setup()
require "mini.surround".setup()
require "mini.basics".setup({
	options = {
		basic = false,
		extra_ui = true,
		win_borders = 'bold',
	}
})
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },

		-- `s` key
		{ mode = 'n', keys = 's' },
	},

	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		-- mapping grous
		{ mode = 'n', keys = '<Leader>t', desc = '+Tabs' },
	},
	window = {
		config = {
			width = "auto",
		},
		delay = 100,
	}
})

vim.cmd("colorscheme tokyonight")
vim.lsp.enable({ "lua_ls" })

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- misc
map("n", "<leader>w", ":write<CR>", { desc = "Save" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format with LSP" })
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true }) -- clear search highlight

-- reload config
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload config" })

-- Pick bindings
map("n", "<leader>f", ":Pick files<CR>", { desc = "File picker" })
map("n", "<leader>h", ":Pick help<CR>", { desc = "Help picker" })
map("n", "<leader>b", ":Pick buffers<CR>", { desc = "Buffer picker" })
map("n", "<leader>e", ":Pick explorer<CR>", { desc = "File Explorer" })
map("n", "<leader>/", ":Pick grep_live tool='rg'<CR>", { desc = "Live Grep" })
map("n", "<leader>'", ":Pick resume<CR>", { desc = "Open last picker" })

-- Tab bindings
map("n", "<leader>tc", ":tabnew<CR>", { desc = "test Create new tab" })           -- space+t creates new tab
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })           -- space+x closes current tab
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Move to the previous tab" }) -- space+pt moves to previous tab
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Move to the next tab" })         -- space+nt moves to next tab

-- easy split generation
map("n", "<leader>v", ":vsplit", { desc = "Create a vertical split" })  -- space+v creates a veritcal split
map("n", "<leader>s", ":split", { desc = "Create a horisontal split" }) -- space+s creates a horizontal split

-- easy split navigation
map("n", "<C-h>", "<C-w>h", { desc = "Switch to the left split" })   -- control+h switches to left split
map("n", "<C-l>", "<C-w>l", { desc = "Switch to the right split" })  -- control+l switches to right split
map("n", "<C-j>", "<C-w>j", { desc = "Switch to the bottom split" }) -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k", { desc = "Switch to the top split" })    -- control+k switches to top split

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>", { desc = "Resize vertical split +" })  -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>", { desc = "Resize vertical split +" }) -- Control+Right resizes vertical split -

-- buffer navigation
map("n", "<leader>x", "<Esc>:bprevious<bar>bdelete #<Return>", { desc = "Delete current buffer" }) -- Space+d delets current buffer

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = "Replace all instances of highlighted words" }) -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>", { desc = "Sort highlighted text in visual mode with Control+S" })                -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })                                          -- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move current line up" })                                            -- Move current line up

-- Scrolling remaps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Copy/paste with system clipboard
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "<leader>p", '"+P', { desc = "Paste from system clipboard" })
