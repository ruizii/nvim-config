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

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function()
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true })
					vim.keymap.set(
						"n",
						"gd",
						"<cmd>Telescope lsp_definitions<cr>",
						{ desc = "Show lsp definitions", buffer = true }
					)
					vim.keymap.set(
						"n",
						"gD",
						"<cmd>lua vim.lsp.buf.declaration()<cr>",
						{ desc = "Go to declaration", buffer = true }
					)
					vim.keymap.set(
						{ "n", "v" },
						"<leader>la",
						"<cmd>lua vim.lsp.buf.code_action()<cr>",
						{ desc = "Code actions", buffer = true }
					)
					vim.keymap.set(
						"n",
						"gi",
						"<cmd>Telescope lsp_implementations<cr>",
						{ desc = "Show lsp implementations", buffer = true }
					)
					vim.keymap.set(
						"n",
						"go",
						"<cmd>Telescope lsp_type_definitions<cr>",
						{ desc = "Show lsp type definitions", buffer = true }
					)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = true })
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = true })
					vim.keymap.set(
						"n",
						"<leader>lr",
						"<cmd>lua vim.lsp.buf.rename()<cr>",
						{ desc = "Lsp rename", buffer = true }
					)
					vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = true })
					vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = true })
					vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = true })
				end,
			})

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
					capabilities = capabilities,
					on_init = on_init,
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							format = { enable = false },
							hint = {
								enable = true,
								arrayIndex = "Disable",
							},
							completion = {
								enable = true,
								callSnippet = "Replace",
							},
							workspace = {
								checkThirdParty = false,
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				}),
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_init = on_init,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_init = on_init,
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
				capabilities = capabilities,
				on_init = on_init,
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
				capabilities = capabilities,
				on_init = on_init,
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
				on_init = on_init,
			})

			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_init = on_init,
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
