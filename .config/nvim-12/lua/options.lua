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
