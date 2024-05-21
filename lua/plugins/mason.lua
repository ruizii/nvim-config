return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			ui = { border = "single" },
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
