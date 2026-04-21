--###########
--# Plugins #
--###########

vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
    "https://github.com/sainnhe/gruvbox-material",
	"https://github.com/nvim-mini/mini.nvim",
    "https://github.com/OXY2DEV/markview.nvim",
})

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.cmd.colorscheme('gruvbox-material')


require("mini.completion").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.pick").setup()
require("mini.extra").setup()
require("mini.diff").setup()
require("mini.git").setup()
require("mini.tabline").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },

		-- `s` key
		{ mode = "n", keys = "s" },

		-- `][` keys
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },

		-- Mini.Surround
		{ mode = "n", keys = "s" },
		{ mode = "v", keys = "s" },
	},

	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		-- mapping grous
		{ mode = "n", keys = "<Leader>s", desc = "+Split" },
		{ mode = "n", keys = "<Leader>l", desc = "+LSP" },
		{ mode = "n", keys = "<Leader>f", desc = "+Pickers" },
		{ mode = "n", keys = "<Leader>g", desc = "+Git" },
		{ mode = "n", keys = "<Leader>m", desc = "+Markview" },
	},
	window = {
		config = {
			width = "auto",
		},
		delay = 100,
	},
})
