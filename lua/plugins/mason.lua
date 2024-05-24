return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = "Mason",
		build = ":MasonUpdate",
		dependencies = {
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
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
