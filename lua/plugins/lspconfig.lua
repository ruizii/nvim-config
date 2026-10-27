return {
	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			-- Remove the built-in gr* defaults so `gr` triggers immediately
			for _, lhs in ipairs({ "grn", "grr", "gri", "grt", "grx" }) do
				pcall(vim.keymap.del, "n", lhs)
			end
			pcall(vim.keymap.del, { "n", "x" }, "gra")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end

					vim.keymap.set(
						"n",
						"gd",
						"<cmd>Telescope lsp_definitions<cr>",
						{ desc = "Go to lsp definition", buffer = true }
					)
					vim.keymap.set("n", "gt", function()
						require("telescope.builtin").lsp_type_definitions({
							jump_type = "never",
						})
					end, { desc = "Go to lsp type definition", buffer = true })
					vim.keymap.set(
						"n",
						"<leader>ls",
						"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
						{ desc = "Workspace symbols", buffer = true }
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
						{ desc = "Diagnostics", buffer = true }
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
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references jump_type=never<cr>", { buffer = true })
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
				end,
			})

			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.lsp.config("lua_ls", {
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
						},
					},
				},
			})

			vim.lsp.config("html", {
				filetypes = { "html", "vue" },
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
			})

			vim.lsp.config("pyright", {
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
				settings = {
					json = {
						validate = { enable = true },
						format = { enable = false },
					},
				},
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
