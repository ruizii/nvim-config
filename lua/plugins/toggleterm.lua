return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<C-t>",
			"<cmd>ToggleTerm<cr>",
			desc = "Toggle terminal",
			mode = { "n", "t" },
		},
	},
	opts = {
		direction = "float",
		size = 18,
		hide_numbers = true,
		start_in_insert = true,
	},
}
