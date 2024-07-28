return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{
			"<C-b>",
			"<cmd>Neotree toggle<CR>",
			desc = "Explorer NeoTree",
		},
	},
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				mappings = {
					["<C-b>"] = "none",
				},
				width = 28,
			},
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = " File" },
					{ source = "buffers", display_name = "󰈙 Bufs" },
					{ source = "git_status", display_name = "󰊢 Git" },
					{ source = "diagnostics", display_name = "󰒡 Diagnostic" },
				},
			},
		})
	end,
}
