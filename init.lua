require "core"

local colorscheme_name = "neodark"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opts = {
	{
		ui = {
			border = "single",
		},

		performance = {
			cache = {
				path = vim.fn.stdpath("cache") .. "/lazy/cache",
				disable_events = { "VimEnter", "BufReadPre" },
			},
			rtp = {
				reset = true,
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"spellfile",
					"shada",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	},
}

require("lazy").setup({import = "plugins"}, opts)

pcall(require, "plugins.colorschemes." .. colorscheme_name)

vim.cmd.colorscheme(colorscheme_name)
