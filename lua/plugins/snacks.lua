return {
	"folke/snacks.nvim",
	event = "UIEnter",
	opts = {
		bigfile = { enabled = true },
		input = {
			enabled = true,
		},
		notifier = {
			enabled = true,
			timeout = 2500,
			margin = { top = 0, right = 0, bottom = 0 },
			style = "minimal",
			top_down = false,
		},
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
		},

		styles = {
			input = {
				relative = "cursor",
				width = 30,
				border = "single",
				keys = {
					i_esc = { "<Esc>", { "cmp_close", "cancel" }, mode = "i" },
				},
			},
			notification = {
				border = "single",
			},
		},
	},
}
