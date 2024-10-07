return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		main = "rainbow-delimiters.setup",
	},
	version = false,
	build = ":TSUpdate",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	opts = function()
		local options = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		}
		return options
	end,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
