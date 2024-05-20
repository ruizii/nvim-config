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

require("lazy").setup({
	{
		import = "plugins",

		defaults = {
			lazy = false,
			version = false,
		},

		ui = {
			border = "single",
		},

		checker = {
			enabled = true,
		},

		performance = {
			cache = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/lazy/cache",
				disable_events = { "VimEnter", "BufReadPre" },
			},
			reset_packpath = true,
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
					"syntax_completion",
				},
			},
		},
	},
})
