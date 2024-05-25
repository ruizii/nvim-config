return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
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
		"RRethy/vim-illuminate",
		event = { "InsertEnter" },

		config = function()
			-- change the highlight style
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

			--- auto update the highlight style on colorscheme change
			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				pattern = { "*" },
				callback = function()
					vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
					vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
					vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
				end,
			})

			require("illuminate").configure({
				delay = 400,
				large_file_cutoff = 2000,
				providers = {
					"lsp",
				},
				filetypes_denylist = {
					"TelescopePrompt",
					"neo-tree",
				},
				min_count_to_highlight = 2,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"lazy",
					"mason",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		main = "rainbow-delimiters.setup",
	},
	{
		"xiyaowong/transparent.nvim",
		opts = {
			extra_groups = {
				"NormalFloat",
				"FloatBorder",
				"Pmenu",
				"WinBar",
			},
			exclude_groups = {
				"Normal",
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			enable_named_colors = true,

			enable_tailwind = true,
		},
	},
	{
		"dstein64/nvim-scrollview",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs_on_startup = { "all" },
		},
		config = function()
			require("scrollview").setup({})
			require("scrollview.contrib.gitsigns").setup()
		end,
	},
}
