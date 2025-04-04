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

			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

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

			lspconfig.zls.setup({
				capabilities = capabilities,
			})

			lspconfig.volar.setup({
				capabilities = capabilities,
				filetypes = { "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
					typescript = {
						tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
					},
				},
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				init_options = {
					typescript = {
						tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
					},
				},
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "vue" },
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
			})

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

			lspconfig.jsonls.setup({
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

			lspconfig.intelephense.setup({
				capabilities = capabilities,
				init_options = {
					globalStoragePath = function()
						if vim.fn.has("win32") == 1 then
							return os.getenv("UserProfile") .. "/.intelephense"
						else
							return os.getenv("HOME") .. "/.local/share/intelephense"
						end
					end,
				},
				format = {
					enable = false,
				},
			})

			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
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
