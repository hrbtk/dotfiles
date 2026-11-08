-- Leader keys (set first, before any mappings or plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--###########
--# Options #
--###########

-- Netrw
-- vim.g.netrw_banner = 0 -- Hide the banner (still broken)
vim.g.netrw_liststyle = 3 -- use tree mode

-- Grep
if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

-- General
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.mouse = "a"             -- enable the mouse in all modes
vim.o.confirm = true          -- prompt to save instead of erroring on :q

-- Appearance
vim.o.number = true           -- Show line numbers
vim.o.relativenumber = true   -- Show relative line numbers
vim.o.cursorline = true       -- Highlight current line
vim.o.splitbelow = true       -- Horizontal splits will be below
vim.o.splitright = true       -- Vertical splits will be to the right
vim.o.splitkeep = "screen"    -- Less text jumping when splitting
vim.o.wrap = false            -- Display long lines as just one line

vim.o.signcolumn = "yes"      -- Always show sign column (otherwise it will shift text)
vim.o.fillchars = "eob: "     -- Don't show `~` outside of buffer

vim.o.pumblend = 10           -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10          -- Make popup menu smaller
vim.o.winblend = 10           -- Make floating windows slightly transparent
vim.o.winborder = "rounded"   -- Rounded borders for floating windows

vim.o.scrolloff = 8           -- Scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff = 8       -- Scroll page when cursor is 8 columns from left/right

vim.o.showtabline = 1         -- Tabline: 0=never, 1=when multiple tabs, 2=always
vim.o.showmode = false
-- vim.o.list = true          -- Show trailing whitespace and tabs
-- vim.o.listchars = "tab:» ,trail:·,nbsp:␣"

-- Search
vim.o.ignorecase = true       -- Case insensitive searching
vim.o.smartcase = true        -- ...unless there's a capital letter

-- Editing
vim.o.infercase = true        -- Infer letter cases for a richer built-in keyword completion
vim.o.tabstop = 4             -- Tab width
vim.o.shiftwidth = 4          -- Indent width
vim.o.expandtab = true        -- Spaces instead of tabs

-- Better diff options (check `:set diffopt?`, newer versions may already include this)
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

vim.o.completeopt = "menuone,noselect" -- Customize completions
vim.o.virtualedit = "block"            -- Allow going past the end of line in visual block mode

-- Command-line completion
vim.o.wildmode = "longest:full,full"


--###########
--# Plugins #
--###########

vim.pack.add({
    "https://github.com/hrbtk/nordwave.nvim",
    -- "https://github.com/hrbtk/islands-dark.nvim",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/nvim-mini/mini.statusline",
})

require("nvim-highlight-colors").setup({})
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.statusline").setup()

-- Theme
vim.cmd.colorscheme("nordwave")

--###############
--# Keymappings #
--###############

-- Functional wrapper for mapping custom keybindings
local map = vim.keymap.set

-- Pickers
map("n", "<leader>ff", "<Cmd>Pick files<CR>", { desc = "Files" })
map("n", "<leader><leader>", "<Cmd>Pick buffers<CR>", { desc = "Buffers" })
map("n", "<leader>/", "<Cmd>Pick grep_live<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<Cmd>Pick help<CR>", { desc = "Help" })

-- Misc
map("n", "<Esc>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { silent = true, desc = "Clear search highlight" })
map("n", "<leader>e", "<Cmd>Explore<CR>", { desc = "File Explorer" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>x", "<Cmd>bdelete<CR>", { desc = "Close current buffer" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- System clipboard (plain y/d/p now stay inside Neovim)
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Copy line end to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("x", "<leader>p", '"_d"+P', { desc = "Paste from system clipboard over selection" })

-- Comment
map("n", "<leader>c", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "Toggle comment", remap = true })

-- Resizing
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Move lines up/down
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Scrolling remaps
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

-- Search results (n always searches forward, N backward, regardless of / or ?)
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Quickfix navigation (centered)
map("n", "[q", "<Cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
map("n", "]q", "<Cmd>cnext<CR>zz", { desc = "Next quickfix item" })

-- Replace all instances of highlighted text
map("v", "<leader>r", '"hy:%s/<C-r>h//g<Left><Left>', { desc = "Buffer find and replace (selected)" })

-- Replace word under cursor in the current buffer
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "Replace word under cursor" })

-- Replace word under cursor, choosing the scope from a menu
local function replace_word()
    local word = vim.fn.expand("<cword>")
    if word == "" then
        vim.notify("No word under cursor", vim.log.levels.WARN)
        return
    end

    local scopes = { "Buffer", "Buffers (confirm each)" }
    if vim.fn.executable("rg") == 1 then
        table.insert(scopes, "Project (confirm each)")
    end

    vim.ui.select(scopes, { prompt = "Replace '" .. word .. "' in:" }, function(choice)
        if not choice then return end
        vim.ui.input({ prompt = "Replace with: ", default = word }, function(new)
            if not new or new == "" or new == word then return end
            local pat = [[\<]] .. vim.fn.escape(word, [[\/]]) .. [[\>]]
            local rep = vim.fn.escape(new, [[\/&]])
            local sub = ("%%s/%s/%s/"):format(pat, rep)

            if choice == "Buffer" then
                vim.cmd(sub .. "g")
            elseif choice == "Buffer (confirm each)" then
                vim.cmd(sub .. "gc")
            else
                vim.cmd("silent grep! -w -F -- " .. vim.fn.shellescape(word))
                if #vim.fn.getqflist() == 0 then
                    vim.notify("No matches for '" .. word .. "'", vim.log.levels.WARN)
                    return
                end
                vim.cmd("cfdo " .. sub .. "gce | update")
            end
        end)
    end)
end

map("n", "<leader>R", replace_word, { desc = "Replace word (choose scope)" })


-- ############
-- # Autocmds #
-- ############

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Don't continue comments on new lines
-- (set in FileType because ftplugins reset formatoptions after init.lua runs)
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function()
        vim.opt_local.formatoptions = "qjl1"
    end,
})

-- Auto-close terminal when process exits successfully
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function(args)
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(args.buf, { force = true })
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
        vim.cmd("startinsert")
    end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Create directories when saving files (skips URL-style buffers like scp://)
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function(args)
        if args.match:match("^%w%w+://") then
            return
        end
        local dir = vim.fn.fnamemodify(args.file, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})
