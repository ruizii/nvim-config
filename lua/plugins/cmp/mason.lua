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
				require("lspconfig").lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							hint = {
								enable = true,
								arrayIndex = "Disable",
							},
						},
					},
				}),
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
