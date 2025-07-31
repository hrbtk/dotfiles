vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { 
		"lua_ls", 
		"rust_analyzer",
		"gopls",
		"jdtls",
		"bashls",
		"clangd",
		-- "java_language_server",
	},
	automatic_enable = {
		exclude = {
			"ts_ls"
		}
	}
})
