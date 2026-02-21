--###########
--# Options #
--###########

-- Netrw
vim.g.netrw_liststyle = 3 -- use tree mode

-- Theme
vim.cmd.colorscheme("default")

-- General
vim.o.undofile    = false
vim.o.swapfile    = false
vim.o.backup      = false
vim.o.writebackup = false
vim.o.autoread    = true
vim.o.mouse       = 'a'              -- enable the mouse in all modes
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- Appearence
vim.o.number         = true      -- Show line numbers
vim.o.relativenumber = true      -- Show relative line numbers
vim.o.cursorline     = true      -- Highlight current line
vim.o.splitbelow     = true      -- Horizontal splits will be below
vim.o.splitright     = true      -- Vertical splits will be to the right
vim.o.wrap           = false     -- Display long lines as just one line
vim.o.showmode       = false     -- Don't show mode in command line

vim.o.termguicolors  = true      -- Enable 24-bit colors
vim.o.showmatch      = true      -- Highlight matching brackets
vim.o.matchtime      = 2         -- How long to show matching bracket
vim.o.cmdheight      = 1         -- Command line height
vim.o.conceallevel   = 0         -- Don't hide markup
vim.o.concealcursor  = ""        -- Don't hide cursor line markup
vim.o.lazyredraw     = true      -- Don't redraw during macros

vim.o.signcolumn     = "yes"     -- Always show sign column (otherwise it will shift text)
vim.o.fillchars      = "eob: "   -- Don't show `~` outside of buffer

vim.o.pumblend       = 10        -- Make builtin completion menus slightly transparent
vim.o.pumheight      = 10        -- Make popup menu smaller
vim.o.winblend       = 10        -- Make floating windows slightly transparent
vim.o.winborder      = "rounded" -- Make floating windows slightly transparent

vim.o.scrolloff      = 8         -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff  = 8         -- scroll page when cursor is 8 spaces from left/right

vim.o.showtabline  = 1         -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.o.tabline      = ''        -- Use default tabline (empty string uses built-in)

-- Search
vim.o.ignorecase     = true -- enable case insensitive searching
vim.o.incsearch      = true -- enable incremental searching
vim.o.smartcase      = true -- all searches are case insensitive unless there's a capital letter
vim.o.hlsearch       = true -- Highlight search results

-- Editing
vim.o.infercase      = true    -- Infer letter cases for a richer built-in keyword completion
vim.o.smartindent    = true    -- Smart auto-indenting
vim.o.autoindent     = true    -- Copy indent from current line
vim.o.tabstop        = 4       -- Tab width
vim.o.shiftwidth     = 4       -- Indent width
vim.o.expandtab      = true    -- Spaces instead of tabs
vim.o.fileencoding   = "utf-8" -- encoding set to utf-8
vim.o.clipboard      = "unnamedplus"

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

vim.o.completeopt    = 'menuone,noselect' -- Customize completions
vim.o.virtualedit    = 'block'            -- Allow going past the end of line in visual block mode
vim.o.formatoptions  = 'qjl1'             -- Don't autoformat comments

-- Command-line completion
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

--###############
--# Keymappings #
--###############

-- Leader key
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Functional wrapper for mapping custom keybindings
local map            = vim.keymap.set

-- misc
map("n", "<BS><BS>", "<Cmd>suspend<CR>", { desc = "Suspend" })
map('n', '<Esc>', "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { silent = true }) -- clear search highlight
map("n", "<leader>e", "<Cmd>Explore<CR>", { desc = "File Explorer" })
map("n", "<leader>rc", "<Cmd>e $HOME/.config/nvim/init.lua<CR>", { silent = true, desc = "Edit config" })
map("n", "<leader>rl", "<Cmd>so $HOME/.config/nvim/init.lua<CR>", { silent = true, desc = "Reload config" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Comment
map("n", "<leader>c", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "Toggle comment", remap = true })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Splitting & Resizing
map("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>sd", "<Cmd>close<CR>", { desc = "Close split" })

map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Replace all instances of highlighted words
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")

-- Move lines up/down
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", "<Cmd>m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", "<Cmd>m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

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

-- ############
-- # Autocmds #
-- ############

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, { force = true })
        end
    end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        local dir = vim.fn.fnamemodify(vim.fn.expand('<afile>'), ':p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})
