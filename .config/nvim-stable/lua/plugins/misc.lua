
return {
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},

	-- Netrw replacement
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({ use_devicons = true })
		end,
	},
}
