return {
	"folke/edgy.nvim",
	enabled = false,
	lazy = false,
	opts = {
		left = {},
		bottom = {
			{
				ft = "noice",
				title = "Logs",
				size = { height = 0.4 },
				filter = function(buf, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
			},
			{
				ft = "help",
				size = { height = 20 },
				-- don't open help files in edgy that we're editing
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},
		exit_when_last = true,
		animate = {
			enabled = true,
			fps = 100,
			cps = 240,
		},
	},
}
