return {
	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",

		config = function()
			local on_init = function(client)
				if client.supports_method("textDocument/semanticTokens") then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end

			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			local sign = function(opts)
				vim.fn.sign_define(opts.name, {
					texthl = opts.name,
					text = opts.text,
					numhl = "",
				})
			end

			sign({ name = "DiagnosticSignError", text = "" })
			sign({ name = "DiagnosticSignWarn", text = "" })
			sign({ name = "DiagnosticSignHint", text = "󰠠" })
			sign({ name = "DiagnosticSignInfo", text = "" })

			lspconfig.lua_ls.setup({
				lspconfig.lua_ls.setup({
					on_init = on_init,
					capabilities = capabilities,
					settings = {
						Lua = {
							format = { enable = false },
							hint = {
								enable = true,
								arrayIndex = "Disable",
							},
							completion = {
								enable = true,
								callSnippet = "Replace",
							},
						},
					},
				}),
			})

			lspconfig.gopls.setup({
				on_init = on_init,
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				on_init = on_init,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=none",
				},
			})

			lspconfig.pyright.setup({
				on_init = on_init,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportWildcardImportFromLibrary = "none",
							},
						},
					},
				},
			})

			lspconfig.jsonls.setup({
				on_init = on_init,
				capabilities = capabilities,
				settings = {
					json = {
						validate = { enable = true },
						format = { enable = false },
					},
				},
				on_new_config = function(config)
					config.settings.json.schemas = config.settings.json.schemas or {}
					vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
				end,
			})

			lspconfig.bashls.setup({
				capabilities = capabilities,
			})

			lspconfig.eslint.setup({
				on_init = on_init,
				capabilities = capabilities,
				settings = { format = false },
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				severity_sort = false,
				underline = true,
				float = {
					border = "single",
					source = true,
				},
			})
		end,
	},
}
