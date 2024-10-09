return {
	"saghen/blink.cmp",
	lazy = false,
	-- optional: provides snippets for the snippet source
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "v0.*",

	opts = {
		keymap = {
			show = {},
			accept = "<C-y>",
			select_prev = { "<Up>", "<C-p>" },
			select_next = { "<Down>", "<C-n>" },
			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
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
				max_width = 80,
				max_height = 20,
				auto_show_delay = 10,
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
