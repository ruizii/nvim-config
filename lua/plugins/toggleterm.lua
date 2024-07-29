return {
	{
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
			direction = "horizontal",
			size = 18,
			hide_numbers = true,
			start_in_insert = true,
		},
	},
}
