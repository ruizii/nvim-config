return {
	"kawre/leetcode.nvim",
	lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		---@type lc.lang
		lang = "cpp",
		arg = "leetcode.nvim",
	},
}
