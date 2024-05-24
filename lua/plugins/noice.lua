return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			hover = {
				enabled = true,
			},
			signature = {
				enabled = true,
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		views = {
			mini = {
				win_options = {
					winblend = 0,
				},
				position = { col = -3 },
			},
			cmdline_popup = {
				border = {
					style = "single",
				},
				filter_options = {},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			hover = {
				border = {
					style = "single",
				},
			},
		},
		routes = {
			{ filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
			{ filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
			{ filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },

			-- search pattern not found
			{ filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },

			-- Word added to spellfile via `zg`
			{ filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },

			-- nvim-treesitter
			{ filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
			{ filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },
		},
	},
}
