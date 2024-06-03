return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		main = "rainbow-delimiters.setup",
	},
	version = false,
	build = ":TSUpdate",
	lazy = vim.fn.argc(-1) == 0,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	opts = function()
		local options = {
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		}
		return options
	end,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
