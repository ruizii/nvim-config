return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		enabled = function()
			return not vim.tbl_contains({ "text", "markdown" }, vim.bo.filetype)
				and vim.bo.buftype ~= "prompt"
				and vim.b.completion ~= false
		end,

		keymap = {
			preset = "default",
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},

		completion = {
			trigger = {
				show_in_snippet = false,
			},
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				end,
				min_width = 10,
				max_height = 10,
				border = "single",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
				},
				scrolloff = 0,
			},
			documentation = {
				window = {
					max_width = 80,
					border = "single",
				},
			},
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		},

		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = false,

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
				highlight = function(ctx)
					local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
					return hl
				end,
			},
		},
	},
}
