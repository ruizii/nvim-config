return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = vim.fn.argc(-1) == 0,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },

	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		enabled = false,
		main = "rainbow-delimiters.setup",
	},

	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,

	config = function()
		---@diagnostic disable-next-line
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
