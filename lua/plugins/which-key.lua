return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
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
		})
	end,
}
