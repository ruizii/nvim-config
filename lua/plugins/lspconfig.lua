return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
			},
		},

		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

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

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"bashls",
					"cssls",
					"eslint",
					"jsonls",
					"lua_ls",
					"pyright",
				},
				handlers = {
					function(server)
						lspconfig[server].setup({ capabilities = capabilities })
					end,
					gopls = function()
						lspconfig.gopls.setup({
							capabilities = capabilities,
						})
					end,
					clangd = function()
						lspconfig.clangd.setup({
							-- init_options = {
							-- 	fallbackFlags = { "--std=c++20" },
							-- },
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
					end,
					eslint = function()
						lspconfig.eslint.setup({
							capabilities = capabilities,
							settings = { format = false },
						})
					end,
					jsonls = function()
						lspconfig.jsonls.setup({
							capabilities = capabilities,
							settings = {
								json = {
									validate = { enable = true },
									format = { enable = true },
								},
							},
							on_new_config = function(config)
								config.settings.json.schemas = config.settings.json.schemas or {}
								vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
							end,
						})
					end,
					pyright = function()
						lspconfig.pyright.setup({
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
					end,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							on_init = function(client)
								local path = client.workspace_folders
									and client.workspace_folders[1]
									and client.workspace_folders[1].name
								if
									not path
									or not (
										vim.uv.fs_stat(path .. "/.luarc.json")
										or vim.uv.fs_stat(path .. "/.luarc.jsonc")
									)
								then
									client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
										Lua = {
											runtime = {
												version = "LuaJIT",
											},
										},
									})
									client.notify(
										vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
										{ settings = client.config.settings }
									)
								end
								return true
							end,
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
						})
					end,
				},
			})
		end,
	},
}
