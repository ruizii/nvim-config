return {
	"folke/which-key.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		plugins = { spelling = true },
		key_labels = { ["<leader>"] = "SPC" },
		icons = {
			group = vim.g.icons_enabled ~= false and "" or "+",
			separator = "-",
		},
		disable = { filetypes = { "TelescopePrompt" } },
		window = {
			border = "single",
		},
	},
}
