return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			options = {
				separator_style = { "", "" },
				modified_icon = "●",
				left_trunc_marker = ".",
				right_trunc_marker = ".",
				max_name_length = 15,
				max_prefix_length = 6,
				diagnostics = "nvim_lsp",
				show_buffer_icons = true,
				persist_buffer_sort = true,
				enforce_regular_tabs = true,
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" },
				},
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and "" or ""
					return icon .. count
				end,
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			enable_named_colors = true,

			enable_tailwind = true,
		},
	},
	{
		"dstein64/nvim-scrollview",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			signs_on_startup = { "all" },
		},
		config = function()
			require("scrollview").setup({})
			require("scrollview.contrib.gitsigns").setup()
		end,
	},
}
