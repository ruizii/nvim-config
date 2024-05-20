return {
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonLog",
		},
		opts = {
			ui = {
				border = "single",
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		-- overrides `require("mason-lspconfig").setup(...)`
		opts = {
			-- add more things to the ensure_installed table protecting against community packs modifying it
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
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end, -- default for anything that doesn't have an explicit handler
				require("lspconfig").lua_ls.setup({}),
				require("lspconfig").pyright.setup({
					settings = {
						python = {
							analysis = {
								diagnosticSeverityOverrides = {
									reportWildcardImportFromLibrary = "none",
								},
							},
						},
					},
				}),
				require("lspconfig").clangd.setup({
					capabilities = {
						offsetEncoding = "utf-8",
					},
				}),
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = function(_, opts)
			-- add more things to the ensure_installed table protecting against community packs modifying it
			opts.ensure_installed = {
				-- Formatters
				"black",
				"isort",
				"prettierd",
				"shfmt",
				"stylua",

				-- Linters
				"selene",
				"shellcheck",
			}
		end,
	},
}
