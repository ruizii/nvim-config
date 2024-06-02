return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "single",
				keymaps = {
					apply_language_filter = "<leader>f",
				},
			},
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"lua_ls",
				"pyright",
				"tsserver",
				"eslint",
			},
		},
	},
}
