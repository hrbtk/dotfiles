vim.g.mapleader = " "        -- sets leader key
vim.g.netrw_banner = 0       -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1         -- change from left splitting to right splitting
vim.g.netrw_liststyle = 3    -- tree style view in netrw
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
vim.opt.title = true         -- show title
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false     -- turn off vi compatibility mode
vim.opt.number = true          -- turn on line numbers
vim.opt.relativenumber = true  -- turn on relative line numbers
vim.opt.mouse = 'a'            -- enable the mouse in all modes
vim.opt.ignorecase = true      -- enable case insensitive searching
vim.opt.smartcase = true       -- all searches are case insensitive unless there's a capital letter
vim.opt.hlsearch = true	       -- disable all highlighted search results
vim.opt.incsearch = true       -- enable incremental searching
vim.opt.wrap = true            -- enable text wrapping
vim.opt.tabstop = 4            -- tabs=4spaces
vim.opt.shiftwidth = 4
vim.opt.fileencoding = "utf-8" -- encoding set to utf-8
vim.opt.pumheight = 10         -- number of items in popup menu
vim.opt.showtabline = 2        -- always show the tab line
vim.opt.laststatus = 2         -- always show statusline
vim.opt.signcolumn = "auto"
vim.opt.expandtab = false      -- expand tab
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.showmode = true
vim.opt.scrolloff = 8     -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right
vim.opt.guifont = "monospace:h18"
vim.opt.clipboard = unnamedplus
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.splitbelow = true    -- split go below
vim.opt.splitright = true    -- vertical split to the right
vim.opt.termguicolors = true -- terminal gui colors
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

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- reload config
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>") -- reload neovim config

-- Tab bindings
map("n", "<leader>t", ":tabnew<CR>")       -- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")     -- space+x closes current tab
map("n", "<leader>pt", ":tabprevious<CR>") -- space+pt moves to previous tab
map("n", "<leader>nt", ":tabnext<CR>")     -- space+nt moves to next tab

-- easy split generation
map("n", "<leader>v", ":vsplit") -- space+v creates a veritcal split
map("n", "<leader>s", ":split")  -- space+s creates a horizontal split

-- easy split navigation
map("n", "<C-h>", "<C-w>h") -- control+h switches to left split
map("n", "<C-l>", "<C-w>l") -- control+l switches to right split
map("n", "<C-j>", "<C-w>j") -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k") -- control+k switches to top split

-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")       -- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>") -- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")     -- Space+d delets current buffer

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>")  -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>") -- Control+Right resizes vertical split -

-- Open netrw in 25% split in tree view
map("n", "<leader>e", ":25Lex<CR>") -- space+e toggles netrw tree view

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>") -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")                         -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")                      -- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")                      -- Move current line up

-- Scrolling remaps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Automatically close quotes, parenthesis, and brackets
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")
map("i", "<", "<><left>")
