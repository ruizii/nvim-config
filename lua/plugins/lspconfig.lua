local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			vim.keymap.set({ "v", "n" }, "<leader>la", require("actions-preview").code_actions)
			require("actions-preview").setup({
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.6,
						height = 0.7,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = function(_, _, max_lines)
							return max_lines - 15
						end,
					},
				},
			})
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = true,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
		opts = {},
	},
}

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall", "LspStart" }

Plugin.event = { "BufReadPost", "BufNewFile" }

function Plugin.init()
	local sign = function(opts)
		-- See :help sign_define()
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	sign({ name = "DiagnosticSignError", text = "✘" })
	sign({ name = "DiagnosticSignWarn", text = "▲" })
	sign({ name = "DiagnosticSignHint", text = "⚑" })
	sign({ name = "DiagnosticSignInfo", text = "»" })

	-- See :help vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		severity_sort = true,
		float = {
			border = "single",
			source = "if_many",
		},
	})
end

function Plugin.config()
	require("neodev").setup({})
	local lspconfig = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

	local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		desc = "LSP actions",
		callback = user.on_attach,
	})

	-- See :help mason-lspconfig-settings
	require("mason-lspconfig").setup({
		ensure_installed = {
			"eslint",
			"tsserver",
			"html",
			"cssls",
			"lua_ls",
		},
		handlers = {
			-- See :help mason-lspconfig-dynamic-server-setup
			function(server)
				-- See :help lspconfig-setup
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end,
			tsserver = function()
				lspconfig.tsserver.setup({
					capabilities = capabilities,
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
					},
				})
			end,
			lua_ls = function()
				lspconfig.lua_ls.setup({
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if
							not vim.loop.fs_stat(path .. "/.luarc.json")
							and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
						then
							client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									library = { vim.env.VIMRUNTIME },
								},
							})
							client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
						end
						return true
					end,
					settings = {
						Lua = {
							format = {
								enable = false,
								hint = {
									enable = true,
									arrayIndex = "Disable",
								},
								completion = {
									{
										callSnippet = "replace",
									},
								},
							},
						},
					},
				})
			end,

			pyright = function()
				lspconfig.pyright.setup({
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
			gopls = function()
				lspconfig.gopls.setup({})
			end,
			clangd = function()
				lspconfig.clangd.setup({
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
		},
	})
end

function user.on_attach()
	local bufmap = function(mode, lhs, rhs)
		local opts = { buffer = true }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- You can search each function in the help page.
	-- For example :help vim.lsp.buf.hover()
	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
	bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
	bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
	bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
	bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
	bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

return Plugin
