return {
	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function()
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true })
					vim.keymap.set(
						"n",
						"gd",
						"<cmd>Telescope lsp_definitions<cr>",
						{ desc = "Go to lsp definition", buffer = true }
					)
					vim.keymap.set(
						"n",
						"<leader>ls",
						"<cmd>Telescope lsp_document_symbols<CR>",
						{ desc = "Document symbols", noremap = true }
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
						"<leader>ld",
						"<cmd>lua require('telescope.builtin').diagnostics({ previewer = false })<CR>",
						{ desc = "Diagnostics", noremap = true }
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
					vim.keymap.set(
						"n",
						"gl",
						"<cmd>lua vim.diagnostic.open_float()<cr>",
						{ desc = "Open diagnostics float", buffer = true }
					)
					vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = true })
					vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = true })
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
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
			})

			vim.lsp.config("ts_ls", {
				typescript = {
					tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
				},
			})

			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
				filetypes = { "html", "vue" },
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
			})

			vim.lsp.config("pyright", {
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

			vim.lsp.config("jsonls", {
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

			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})

			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"cssls",
				"html",
				"gopls",
				"clangd",
				"pyright",
				"jsonls",
				"bashls",
			})

			vim.diagnostic.config({
				virtual_text = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "󰠠",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				update_in_insert = false,
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
