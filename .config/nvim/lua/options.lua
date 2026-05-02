--###########
--# Options #
--###########

-- Netrw
vim.g.netrw_liststyle = 3 -- use tree mode

-- General
vim.o.undofile = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.autoread = true
vim.o.mouse = "a" -- enable the mouse in all modes
vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Appearence
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.cursorline = true -- Highlight current line
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.wrap = false -- Display long lines as just one line
vim.o.showmode = false -- Don't show mode in command line

vim.o.termguicolors = true -- Enable 24-bit colors
vim.o.showmatch = true -- Highlight matching brackets
vim.o.matchtime = 2 -- How long to show matching bracket
vim.o.cmdheight = 1 -- Command line height
vim.o.conceallevel = 0 -- Don't hide markup
vim.o.concealcursor = "" -- Don't hide cursor line markup
vim.o.lazyredraw = true -- Don't redraw during macros

vim.o.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
vim.o.fillchars = "eob: " -- Don't show `~` outside of buffer

vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.winblend = 10 -- Make floating windows slightly transparent
vim.o.winborder = "rounded" -- Make floating windows slightly transparent

vim.o.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right

vim.o.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.o.tabline = "" -- Use default tabline (empty string uses built-in)

-- Search
vim.o.ignorecase = true -- enable case insensitive searching
vim.o.incsearch = true -- enable incremental searching
vim.o.smartcase = true -- all searches are case insensitive unless there's a capital letter
vim.o.hlsearch = true -- Highlight search results

-- Editing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true -- Copy indent from current line
vim.o.tabstop = 4 -- Tab width
vim.o.shiftwidth = 4 -- Indent width
vim.o.expandtab = true -- Spaces instead of tabs
vim.o.fileencoding = "utf-8" -- encoding set to utf-8
vim.o.clipboard = "unnamedplus"

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

vim.o.completeopt = "menuone,noselect" -- Customize completions
vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode
vim.o.formatoptions = "qjl1" -- Don't autoformat comments

-- Command-line completion
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
