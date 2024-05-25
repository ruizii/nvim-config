return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-project.nvim",
				config = function()
					require("telescope").load_extension("project")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"jvgrootveld/telescope-zoxide",
				config = function()
					require("telescope").load_extension("zoxide")
				end,
			},
		},
		config = function()
			-- Function for opening files when tab-selected or opening a single file
			local select_one_or_multi = function(prompt_bufnr)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				local multi = picker:get_multi_selection()
				if not vim.tbl_isempty(multi) then
					require("telescope.actions").close(prompt_bufnr)
					for _, j in pairs(multi) do
						if j.path ~= nil then
							vim.cmd(string.format("%s %s", "edit", j.path))
						end
					end
				else
					require("telescope.actions").select_default(prompt_bufnr)
				end
			end

			local ts = require("telescope")
			local h_percentage = 0.85
			local w_percentage = 1
			local w_limit = 140

			vim.api.nvim_set_hl(0, "TodoBgFIX", { blend = 0 })
			vim.api.nvim_set_hl(0, "TodoBgNOTE", { blend = 0 })
			vim.api.nvim_set_hl(0, "TodoBgTODO", { blend = 0 })
			vim.api.nvim_set_hl(0, "TelescopePathSeparator", { link = "Comment" })

			local standard_setup = {
				borderchars = {
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
						i = {
							["<C-o>"] = require("telescope.actions.layout").toggle_preview,
							["<Esc>"] = require("telescope.actions").close,
							["<CR>"] = select_one_or_multi,
						},
					},
				}),

				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
		end,
	},
}
