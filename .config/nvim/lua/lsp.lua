vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Jari27/lazydev.nvim", version = "deprecate_client_notify" },
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"bashls",
		"clangd",
		-- "rust_analyzer",
		-- "jdtls",
		-- "java_language_server",
	},
	automatic_enable = {
		exclude = {
			"ts_ls"
		}
	}
})
require("lazydev").setup()
