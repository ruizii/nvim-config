return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				config = function()
					require("telescope").load_extension("fzf")
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
			local w_percentage = 0.85
			local w_limit = 140

			vim.api.nvim_set_hl(0, "TelescopePathSeparator", { link = "Comment" })

			ts.setup({
				defaults = {
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
							preview_cutoff = 120,
							preview_height = 0.4,
						},
						vertical = {
							mirror = false,
						},
					},
					results_title = "",
					sorting_strategy = "ascending",
					border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 } },
					path_display = { "filename_first" },
					mappings = {
						i = {
							["<C-o>"] = require("telescope.actions.layout").toggle_preview,
							["<Esc>"] = require("telescope.actions").close,
							["<CR>"] = select_one_or_multi,
							["<C-d>"] = require("telescope.actions").delete_buffer,
						},
					},
				},

				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					smart_open = {
						match_algorithm = "fzf",
					},
				},
			})
		end,
	},
}
