-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- misc
map("n", "<leader>w", ":write<CR>", { desc = "Save" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<BS><BS>", ":suspend<CR>", { desc = "Suspend" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format with LSP" })
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true }) -- clear search highlight

-- reload config
map("n", "<leader><leader>", ":source %<CR>", { desc = "Source current file" })
map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload config" })

-- Pick bindings
map("n", "<leader>ff", ":Pick files<CR>", { desc = "File picker" })
map("n", "<leader>fh", ":Pick help<CR>", { desc = "Help picker" })
map("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Buffer picker" })
map("n", "<leader>fg", ":Pick grep_live tool='rg'<CR>", { desc = "Live Grep" })
map("n", "<leader>e", ":Pick explorer<CR>", { desc = "File Explorer" })
map("n", "<leader>'", ":Pick resume<CR>", { desc = "Open last picker" })
map("n", "<leader>d", ":Pick diagnostic<CR>", { desc = "Diagnostic picker" })

-- Tab bindings
map("n", "<leader>tc", ":tabnew<CR>", { desc = "Create new tab" })                -- space+t creates new tab
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })           -- space+x closes current tab
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Move to the previous tab" }) -- space+pt moves to previous tab
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Move to the next tab" })         -- space+nt moves to next tab

-- easy split generation
map("n", "<leader>v", ":vsplit", { desc = "Create a vertical split" })  -- space+v creates a veritcal split
map("n", "<leader>s", ":split", { desc = "Create a horisontal split" }) -- space+s creates a horizontal split

-- easy split navigation
map("n", "<C-h>", "<C-w>h", { desc = "Switch to the left split" })   -- control+h switches to left split
map("n", "<C-j>", "<C-w>j", { desc = "Switch to the bottom split" }) -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k", { desc = "Switch to the top split" })    -- control+k switches to top split
map("n", "<C-l>", "<C-w>l", { desc = "Switch to the right split" })  -- control+l switches to right split

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>", { desc = "Resize vertical split +" })  -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>", { desc = "Resize vertical split +" }) -- Control+Right resizes vertical split -

-- buffer navigation
map("n", "<leader>x", "<Esc>:bprevious<bar>bdelete #<Return>", { desc = "Delete current buffer" }) -- Space+d delets current buffer
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })                                          -- Go to the next buffer
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })                                -- Go to the previous buffer


-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = "Replace all instances of highlighted words" }) -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>", { desc = "Sort highlighted text in visual mode with Control+S" })                -- Sort highlighted text in visual mode with Control+S

-- Scrolling remaps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Copy/paste with system clipboard
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "<leader>p", '"+P', { desc = "Paste from system clipboard" })

-- Terminal keybindings
map("t", "<esc><esc>", "<C-\\><C-n>") -- escape terminal with double escape
