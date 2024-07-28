return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		require("transparent").setup({
			extra_groups = {
				"NormalFloat",
				"FloatBorder",
				"Pmenu",
				"WinBar",
				"WinBarNC",
				"MiniClueBorder",
				"MiniClueDescSingle",
			},
		})
		require("transparent").clear_prefix("NeoTree")
	end,
}
