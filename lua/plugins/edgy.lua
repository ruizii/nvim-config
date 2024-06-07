return {
	"folke/edgy.nvim",
	event = "User FilePost",
	opts = {
		left = {},
		bottom = {
			{
				ft = "toggleterm",
				title = "Terminal",
				size = { height = 0.36 },
				filter = function(buf, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
				wo = {
					winbar = false,
				},
			},
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
		wo = {

			winhighlight = "WinBar:NONE,Normal:NONE,WinBarNC:NONE",
		},
		animate = {
			enabled = true,
			fps = 100,
			cps = 240,
		},
	},
}
