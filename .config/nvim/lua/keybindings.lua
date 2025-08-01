local map = vim.keymap.set

-- misc
map("n", "<BS><BS>", ":suspend<CR>", { desc = "Suspend" })
map('n', '<Esc>', "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { silent = true }) -- clear search highlight
map("t", "<esc><esc>", "<C-\\><C-n>") -- escape terminal with double escape

-- reload config
map("n", "<leader><leader>", ":source %<CR>", { desc = "Source current file" })
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload config" })

-- Comment
map("n", "<leader>c", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>c", "gc", { desc = "toggle comment", remap = true })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Pick bindings
map("n", "<leader>ff", ":Pick files<CR>", { desc = "File picker" })
map("n", "<leader>fh", ":Pick help<CR>", { desc = "Help picker" })
map("n", "<leader>b", ":Pick buffers<CR>", { desc = "Buffer picker" })
map("n", "<leader>fg", ":Pick grep_live tool='rg'<CR>", { desc = "Live Grep" })
map("n", "<leader>f'", ":Pick resume<CR>", { desc = "Open last picker" })
map("n", "<leader>fd", ":Pick diagnostic<CR>", { desc = "Diagnostic picker" })
map("n", "<leader>fi", ":Pick git_hunks<CR>", { desc = "Git diff picker" })
map("n", "<leader>e", ":Explore<CR>", { desc = "File Explorer" })
-- map("n", "<leader>e", ":Pick explorer<CR>", { desc = "File Explorer" })

-- Tabs bindings
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

-- easy window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })  -- control+h switches to left split
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true }) -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true }) -- control+k switches to top split
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true }) -- control+l switches to right split

-- adjust window sizes easier
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- buffer navigation
map("n", "<leader>x", "<Esc>:bprevious<bar>bdelete #<Return>", { desc = "Delete current buffer" }) -- Space+d delets current buffer
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })                                          -- Go to the next buffer
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })                                -- Go to the previous buffer

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = "Replace all instances of highlighted words" }) -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>", { desc = "Sort highlighted text in visual mode with Control+S" })                -- Sort highlighted text in visual mode with Control+S

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

-- LSP
map("n", "<leader>lD", ":Pick lsp scope='definition'<cr>", { desc = "[G]oto [D]efinition" })
map("n", "<leader>fR", ":Pick lsp scope='references'<cr>", { desc = "References" })
map("n", "<leader>lI", ":Pick lsp scope='implementation'<cr>", { desc = "[G]oto [I]mplementation" })
map("n", "<leader>lt", ":Pick lsp scope='type_definition'<cr>", { desc = "Type Definition" })
map("n", '<leader>la', vim.lsp.buf.signature_help, { desc = 'Arguments popup' })
map("n", '<leader>ld', vim.diagnostic.open_float, { desc = 'Diagnostics popup' })
map("n", '<leader>lf', vim.lsp.buf.format, { desc = 'Format' })
map("n", '<leader>li', vim.lsp.buf.hover, { desc = 'Information' })
map("n", '<leader>lR', vim.lsp.buf.references, { desc = 'References' })
map("n", '<leader>ls', vim.lsp.buf.definition, { desc = 'Source definition' })

-- Diagnostic
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Go to previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1,  float = true }) end, { desc = "Go to next diagnostic" })
map("n", "[w", function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN }) end,  { desc = "Go to previous warning" })
map("n", "]w", function() vim.diagnostic.jump({ count = 1,  float = true, severity = vim.diagnostic.severity.WARN }) end,  { desc = "Go to next warning" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Go to previous error" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1,  float = true, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Go to next error" })
