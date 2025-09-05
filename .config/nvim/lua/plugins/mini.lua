return {
	-- Mini.nvim (many modules)
	{
		"nvim-mini/mini.nvim",
		dependencies = {
			"rafamadriz/friendly-snippets"
		},
		config = function()
			require("mini.pick").setup()
			require("mini.starter").setup()
			require("mini.tabline").setup()
			require("mini.extra").setup()
			require("mini.completion").setup()
			require("mini.pairs").setup()
			require("mini.icons").setup()
			require("mini.git").setup()
			require("mini.diff").setup()
			require("mini.statusline").setup()
			require("mini.surround").setup()
			require("mini.move").setup({
				options = { reindent_linewise = true },
			})
			require("mini.basics").setup({
				options = {
					basic = false,
					extra_ui = true,
					win_borders = "bold",
				},
			})

			-- Mini.clue
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },
					{ mode = "i", keys = "<C-x>" },
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
					{ mode = "n", keys = "s" },
					{ mode = "n", keys = "[" },
					{ mode = "n", keys = "]" },
				},
				clues = {
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
					{ mode = "n", keys = "<Leader><tab>", desc = "+Tabs" },
					{ mode = "n", keys = "<Leader>w",     desc = "+Windows" },
					{ mode = "n", keys = "<Leader>f",     desc = "+Pickers" },
					{ mode = "n", keys = "<Leader>l",     desc = "+LSP" },
					{ mode = "n", keys = "<Leader>s",     desc = "+Surround" },
				},
				window = { config = { width = "auto" }, delay = 100 },
			})

			-- Mini.hipatterns
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			-- Mini.snippets
			local gen_loader = require('mini.snippets').gen_loader
			require('mini.snippets').setup({
				snippets = {
					-- Load custom file with global snippets first (adjust for Windows)
					gen_loader.from_file('~/.config/nvim/snippets/global.json'),

					-- Load snippets based on current language by reading files from
					-- "snippets/" subdirectories from 'runtimepath' directories.
					gen_loader.from_lang(),
				},
			})
		end,
	},
}
