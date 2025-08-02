vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/prichrd/netrw.nvim" }
})

vim.cmd("colorscheme tokyonight")

require "netrw".setup({
	use_devicons = true,
})
require "mini.pick".setup()
require "mini.move".setup()
require "mini.starter".setup()
require "mini.tabline".setup()
require "mini.extra".setup()
require "mini.completion".setup()
require "mini.pairs".setup()
require "mini.icons".setup()
require "mini.git".setup()
require "mini.diff".setup()
require "mini.statusline".setup()
require "mini.surround".setup()
require "mini.basics".setup({
	options = {
		basic = false,
		extra_ui = true,
		win_borders = 'bold',
	}
})
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },

		-- `s` key
		{ mode = 'n', keys = 's' },
	},

	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		-- mapping grous
		{ mode = 'n', keys = '<Leader><tab>', desc = '+Tabs' },
		{ mode = 'n', keys = '<Leader>w', desc = '+Windows' },
		{ mode = 'n', keys = '<Leader>f', desc = '+Pickers' },
		{ mode = 'n', keys = '<Leader>l', desc = '+LSP' },
	},
	window = {
		config = {
			width = "auto",
		},
		delay = 100,
	}
})
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
		hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
		todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
