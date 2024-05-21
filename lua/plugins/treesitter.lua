return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	lazy = true,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	opts = function(_, opts)
		opts.sync_install = false
		opts.highlight = {
			additional_vim_regex_highlighting = false,
			enable = true,
		}

		opts.indent = {
			enable = false,
		}

		opts.ensure_installed = {
			"lua",
			"vim",
			"bash",
			"c",
			"cpp",
			"css",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"toml",
			"typescript",
			"vimdoc",
		}
	end,
}
