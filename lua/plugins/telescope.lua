-- plugins/telescope.lua:
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local ts = require("telescope")
			local h_percentage = 0.85
			local w_percentage = 1
			local w_limit = 140

			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "Normal:bg", blend = 0 })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "Normal:bg", blend = 0 })
			vim.api.nvim_set_hl(0, "TodoBgFIX", { blend = 0 })
			vim.api.nvim_set_hl(0, "TodoBgNOTE", { blend = 0 })
			vim.api.nvim_set_hl(0, "TodoBgTODO", { blend = 0 })

			local standard_setup = {
				borderchars = {
					--           N    E    S    W   NW   NE   SE   SW
					prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						width = function(_, cols, _)
							return math.min(math.floor(w_percentage * cols), w_limit)
						end,
						height = function(_, _, rows)
							return math.floor(rows * h_percentage)
						end,
						preview_width = 80,
						preview_cutoff = 10,
						preview_height = 0.4,
					},
				},
			}

			ts.setup({
				defaults = vim.tbl_extend("error", standard_setup, {
					results_title = "",
					sorting_strategy = "ascending",
					border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 } },
					path_display = { "filename_first" }, -- trunctate or filename_first
					mappings = {
						n = {
							["o"] = require("telescope.actions.layout").toggle_preview,
							["<C-c>"] = require("telescope.actions").close,
						},
						i = {
							["<C-o>"] = require("telescope.actions.layout").toggle_preview,
						},
					},
				}),

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
