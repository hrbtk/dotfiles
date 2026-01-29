--###########
--# Options #
--###########

-- Netrw
vim.g.netrw_liststyle = 3 -- use tree mode

-- General
vim.o.undofile        = false
vim.o.swapfile        = false
vim.o.compatible      = false -- turn off vi compatibility mode
vim.o.syntax          = "ON"
vim.o.backup          = false
vim.o.writebackup     = false
vim.o.mouse           = 'a'          -- enable the mouse in all modes
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- theme & transparency
vim.cmd.colorscheme("default")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

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

--###############
--# Keymappings #
--###############

-- Leader key
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Functional wrapper for mapping custom keybindings
local map            = vim.keymap.set

-- misc
map("n", "<BS><BS>", ":suspend<CR>", { desc = "Suspend" })
map('n', '<Esc>', "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { silent = true }) -- clear search highlight
-- map("t", "<esc><esc>", "<C-\\><C-n>")                                                        -- escape terminal with double escape
map("n", "<leader>e", ":Explore<CR>", { desc = "File Explorer" })
map("n", "<leader>rc", ":e $HOME/.config/nvim/init.lua<CR>", { silent = true, desc = "Edit config" })
map("n", "<leader>rl", ":so $HOME/.config/nvim/init.lua<CR>", { silent = true, desc = "Reload config" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Comment
map("n", "<leader>c", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "toggle comment", remap = true })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Splitting & Resizing
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>sd", ":close<CR>", { desc = "Close split" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext <CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious <CR>", { desc = "Prev buffer" })
map("n", "<leader>bc", "<Esc>:bprevious<bar>bdelete #<Return>", { desc = "Delete current buffer" })

-- Replace all instances of highlighted words
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

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

-- Automatically close quotes, parenthesis, and brackets
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")
map("i", "<", "<><left>")

-- ############
-- # Autocmds #
-- ############

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local line = mark[1]
        local ft = vim.bo.filetype
        if line > 0 and line <= lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
            and not vim.o.diff then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "lua", "python" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "javascript", "typescript", "json", "html", "css" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
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
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000


-- #####################
-- # FLOATING TERMINAL #
-- #####################

-- terminal
local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function FloatingTerminal()
    -- If terminal is already open, close it (toggle behavior)
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    -- Create buffer if it doesn't exist or is invalid
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        -- Set buffer options for better terminal experience
        vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
    end

    -- Calculate window dimensions
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Set transparency for the floating window
    vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

    -- Set transparent background for the window
    vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
        'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

    -- Define highlight groups for transparency
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

    -- Start terminal if not already running
    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in ipairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    -- Set up auto-close on buffer leave
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
    if terminal_state.is_open then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })


-- ##############
-- # STATUSLINE #
-- ##############

-- Git branch function
local function git_branch()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch ~= "" then
        return "  [" .. branch .. "] "
    end
    return ""
end

-- Mode indicators with icons
local function mode_icon()
    local mode = vim.fn.mode()
    local modes = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK", -- Ctrl-V
        c = "COMMAND",
        s = "SELECT",
        S = "S-LINE",
        ["\19"] = "S-BLOCK", -- Ctrl-S
        R = "REPLACE",
        r = "REPLACE",
        ["!"] = "SHELL",
        t = "TERMINAL"
    }
    return modes[mode] or "  " .. mode:upper()
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        callback = function()
            vim.opt_local.statusline = table.concat {
                ' %{%v:lua.mode_icon()%}',
                ' %=',
                ' %t',
                ' %r',
                ' %m',
                ' %=',
                '%{v:lua.git_branch()}',
                '%{&filetype}',
                ' %2p%%',
                ' %3l:%-2c '
            }
        end
    })
    vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
        callback = function()
            vim.opt_local.statusline = "  %f %h%m%r │ %{&filetype} | %=  %l:%c   %P "
        end
    })
end

setup_dynamic_statusline()
