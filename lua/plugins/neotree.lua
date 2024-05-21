return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	init = function()
		vim.g.neo_tree_remove_legacy_commands = true
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},

	opts = {
		auto_clean_after_session_restore = true,
		close_if_last_window = true,
		-- sources = {"filesystem", "buffers", "git_status"}
		source_selector = {
			winbar = true,
			content_layout = "center",
		},
		default_component_configs = {
			indent = { padding = 0, indent_size = 1 },
		},

		window = {
			mappings = {
				["<C-b>"] = "none",
				["<leader>o"] = "<cmd>Neotree source=filesystem focus<CR>",
			},
			width = 28,
		},
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},

		event_handlers = {
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
	},
}
