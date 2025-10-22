return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<C-b>",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
		},
	},

	opts = {
		window = {
			mappings = {
				["<C-b>"] = "close_window",
			},
		},
	},
}
