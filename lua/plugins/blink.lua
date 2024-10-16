return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		keymap = {
			show = {},
			accept = "<C-y>",
			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
			show_documentation = {},
			hide_documentation = {},
			scroll_documentation_up = "<C-u>",
			scroll_documentation_down = "<C-d>",
		},
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups. Remove on later release
			use_nvim_cmp_as_default = true,
		},
		windows = {
			autocomplete = {
				min_width = 10,
				border = "single",
				draw = "reversed",
				scrolloff = 0,
			},
			documentation = {
				border = "single",
				auto_show = true,
				auto_show_delay_ms = 50,
				max_width = 80,
			},
		},
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		nerd_font_variant = "mono",
		kind_icons = {
			Function = "λ",
			Snippet = "",
			Text = "󰉿",
			Method = "󰆧",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		},

		-- experimental auto-brackets support
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},

		-- experimental signature help support
		-- trigger = { signature_help = { enabled = true } },
	},
}
