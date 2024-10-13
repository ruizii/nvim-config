return {
	"kawre/leetcode.nvim",
	lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		---@diagnostic disable-next-line
		---@type lc.lang
		---@diagnostic disable-next-line
		lang = "cpp",
		arg = "leetcode.nvim",
	},
}
