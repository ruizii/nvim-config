return {
	{
		"RRethy/vim-illuminate",
		event = "User FilePost",
		config = function()
			-- change the highlight style
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

			require("illuminate").configure({
				delay = 400,
				large_file_cutoff = 2000,
				providers = {
					"lsp",
				},
				filetypes_denylist = {
					"TelescopePrompt",
				},
				min_count_to_highlight = 2,
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = false,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = "User FilePost",
		cmd = { "TodoTrouble", "TodoTelescope" },
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},

		config = function(_, opts)
			local hooks = require("ibl.hooks")
			require("ibl").setup(opts)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "User FilePost",
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			enable_named_colors = false,
			enable_tailwind = true,
			enable_short_hex = false,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = {
			signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		},
	},
	{
		"dstein64/nvim-scrollview",
		event = "User FilePost",
		config = function()
			require("scrollview").setup({
				signs_on_startup = { "diagnostics", "search", "conflicts", "cursor" },
				current_only = true,
				mode = "simple",
			})
			require("scrollview.contrib.gitsigns").setup()
		end,
	},
}
