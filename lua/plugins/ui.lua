return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			})
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "VeryLazy",
		config = function()
			local highlight = {
				"RainbowYellow",
				"RainbowBlue",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowOrange",
				"RainbowRed",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			end)
			vim.g.rainbow_delimiters = { highlight = highlight }

			require("ibl").setup({
				scope = {
					show_start = false,
					show_end = false,
				},
			})
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		config = function()
			require("scrollbar").setup({
				handle = {
					color = "#60606f",
				},
				marks = {
					Cursor = {
						text = "-",
					},
					Search = {
						color = "#FFEA00",
					},
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true, -- Requires gitsigns
					handle = true,
					search = true, -- Requires hlslens
					ale = false, -- Requires ALE
				},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		main = "rainbow-delimiters.setup",
	},
	{
		"xiyaowong/transparent.nvim",
		opts = {
			extra_groups = {
				"NormalFloat",
				"TabLineFill",
				"Comment",
				"NormalNC",
				"TabLine",
				"TabLineSel",
				"FloatBorder",
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			enable_named_colors = true,

			enable_tailwind = true,
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		lazy = true,
		branch = "main",
		config = function()
			require("scrollbar.handlers.search").setup({
				override_lens = function() end,
			})
		end,
	},
}
