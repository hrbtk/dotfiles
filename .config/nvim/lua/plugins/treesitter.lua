return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"html",
					"java",
					"javascript",
					"json",
					"lua",
					"make",
					"markdown",
					"python",
					"rust",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
