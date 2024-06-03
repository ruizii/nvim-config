return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			left = {
				"Trouble",
				{ ft = "trouble", title = "Sidebar" },
			},
			bottom = {
				{
					ft = "noice",
					title = "Log",
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
	},
	{
		"folke/trouble.nvim",
		version = false,
		keys = {
			{ "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>s", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		},
		opts = {
			auto_preview = false,
		},
	},
}
