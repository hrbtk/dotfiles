
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
})
local autocmd = vim.api.nvim_create_autocmd
local ts_parsers = {
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
	"help",
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
	"typst",
	"vim",
	"yaml",
}
local nts = require("nvim-treesitter")
nts.install(ts_parsers)
autocmd("PackChanged", { -- update treesitter parsers/queries with plugin updates
	group = augroup,
	callback = function(args)
		local spec = args.data.spec
		if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
			vim.schedule(function()
				nts.update()
			end)
		end
	end,
})
autocmd("FileType", { -- enable treesitter highlighting and indents
	group = augroup,
	callback = function(args)
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			if vim.treesitter.query.get(filetype, "indents") then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
			vim.treesitter.start()
		end
	end,
})
