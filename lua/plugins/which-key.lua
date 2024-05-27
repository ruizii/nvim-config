return {
	"folke/which-key.nvim",
	spelling = { enabled = false },
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		key_labels = { ["<leader>"] = "SPC" },
		icons = {
			group = vim.g.icons_enabled ~= false and "" or "+",
			separator = "-",
		},
		disable = { filetypes = { "TelescopePrompt" } },
		window = {
			border = "single",
		},
		defaults = {
			mode = { "n", "v" },
			["<leader>l"] = { name = "Lsp" },
			["<leader>f"] = { name = "Telescope" },
		},
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
