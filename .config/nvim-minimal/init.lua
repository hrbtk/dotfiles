-- Leader key
vim.g.mapleader       = " "
vim.g.maplocalleader  = "\\"

-- Netrw
vim.g.netrw_liststyle = 3 -- use tree mode

-- Currently causes bug with clipboard
-- vim.g.netrw_banner    = 0 -- hide Netrw banner

-- General
vim.o.undofile        = false
vim.o.swapfile        = false
vim.o.compatible      = false -- turn off vi compatibility mode
vim.o.syntax          = "ON"
vim.o.backup          = false
vim.o.writebackup     = false
vim.o.mouse           = 'a'          -- enable the mouse in all modes
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

vim.o.ruler          = false     -- Don't show cursor position in command line
vim.o.wrap           = false     -- Display long lines as just one line
vim.o.showmode       = false     -- Don't show mode in command line
vim.o.modeline       = false     -- Don't show mode in command line

vim.o.signcolumn     = "yes"     -- Always show sign column (otherwise it will shift text)
vim.o.fillchars      = "eob: "   -- Don't show `~` outside of buffer

vim.o.pumblend       = 10        -- Make builtin completion menus slightly transparent
vim.o.pumheight      = 10        -- Make popup menu smaller
vim.o.winblend       = 10        -- Make floating windows slightly transparent
vim.o.winborder      = "rounded" -- Make floating windows slightly transparent
vim.o.termguicolors  = true      -- Make floating windows slightly transparent

vim.o.scrolloff      = 8         -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff  = 8         -- scroll page when cursor is 8 spaces from left/right

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

vim.cmd [[
	set path+=**
	colorscheme tokyonight
	highlight Normal ctermbg=NONE guibg=NONE
	filetype plugin on
	set wildmenu
	command! Reload :source ~/.config/nvim/init.lua
	command! Make :!make
]]

--statusline
local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}


vim.cmd "highlight StatusLineAccent guibg=#7aa2f7 guifg=#1a1b26"
vim.cmd "highlight StatuslineInsertAccent guibg=#9ece6a guifg=#1a1b26"
vim.cmd "highlight StatuslineVisualAccent guibg=#bb9af7 guifg=#1a1b26"
vim.cmd "highlight StatuslineReplaceAccent guibg=#f7768e guifg=#1a1b26"
vim.cmd "highlight StatuslineCmdLineAccent guibg=#e0af68 guifg=#1a1b26"
vim.cmd "highlight StatuslineTerminalAccent guibg=#73daca guifg=#1a1b26"

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatusLineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand "%:t"
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
	return table.concat {
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#Normal# ",
		filepath(),
		filename(),
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	}
end

function Statusline.inactive()
	return " %F"
end

vim.api.nvim_exec2([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], {
	output = false,
} )

-- Functional wrapper for mapping custom keybindings
local map = vim.keymap.set

-- misc
map("n", "<BS><BS>", ":suspend<CR>", { desc = "Suspend" })
map('n', '<Esc>', "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { silent = true }) -- clear search highlight
map("t", "<esc><esc>", "<C-\\><C-n>")                                                        -- escape terminal with double escape
map("n", "<leader>e", ":Explore<CR>", { desc = "File Explorer" })

-- reload config
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload config" })

-- Comment
map("n", "<leader>c", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "toggle comment", remap = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Tab bindings
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Windows
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- adjust window sizes easier
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

		-- buffer navigation
map("n", "<Tab>", ":bnext <CR>", { desc = "Next buffer" })                                         -- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>", { desc = "Prev buffer" })                                   -- Shift+Tab goes to previous buffer
map("n", "<leader>x", "<Esc>:bprevious<bar>bdelete #<Return>", { desc = "Delete current buffer" }) -- Space+d delets current buffer

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>") -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")                         -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")                      -- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")                      -- Move current line up

-- Scrolling remaps
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

-- Copy/paste with system clipboard
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
map("x", "<leader>p", '"+P', { desc = "Paste from system clipboard" })

-- Search results
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Automatically close quotes, parenthesis, and brackets
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")
map("i", "<", "<><left>")
