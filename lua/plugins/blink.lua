return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		keymap = "default",
		-- keymap = {
		-- 	preset = "default",
		-- 	["<C-u>"] = { "scroll_documentation_up", "fallback" },
		-- 	["<C-d>"] = { "scroll_documentation_down", "fallback" },
		-- },
		highlight = {
			use_nvim_cmp_as_default = false,
		},
		windows = {
			autocomplete = {
				min_width = 10,
				border = "single",
				draw = {
					columns = { { "label", "label_description" }, { "kind_icon" } },
				},
				scrolloff = 0,
			},
			documentation = {
				border = "single",
				auto_show = true,
				auto_show_delay_ms = 50,
				max_width = 80,
			},
			ghost_text = {
				enabled = true,
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
