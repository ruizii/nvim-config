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
			},
			hover = {
				enabled = true,
				silent = true,
			},
			signature = {
				enabled = true,
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			long_message_to_split = false, -- long messages will be sent to a split
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		views = {
			mini = {
				win_options = {
					winblend = 0,
				},
			},
			hover = {
				border = {
					style = "single",
				},
			},
		},
		cmdline = {
			view = "cmdline",
		},
	},
}
