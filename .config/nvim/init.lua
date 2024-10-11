-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- vim opts
require("vimopts")
-- language specific mappings go here
-- require("mappings")

-- lazy.nvim setup
require("lazy").setup("plugins", {
  default = {
    lazy = true,
  },
})

--theme
vim.cmd("colorscheme tokyonight")

-- treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {
    -- "go",
    "rust",
    "c",
    "lua",
    "java",
    -- "python",
    -- "html",
    -- "css",
    -- "javascript",
    -- "typescript",
    -- "templ",
    -- "prisma",
    -- "haskell",
    -- "zig",
    -- "latex",
    -- "gleam",
    -- "sql",
    -- "wgsl",
    -- "asm",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

