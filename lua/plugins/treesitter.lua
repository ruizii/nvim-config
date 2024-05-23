return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	version = false,
	build = ":TSUpdate",
	lazy = vim.fn.argc(-1) == 0,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	opts = {
		auto_install = true,
		sync_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
