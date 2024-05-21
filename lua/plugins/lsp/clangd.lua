local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.pyright.setup({
	capabilities = lsp_capabilities,
	settings = {
		python = {
			{
				analysis = {
					diagnosticSeverityOverrides = {
						reportWildcardImportFromLibrary = "none",
					},
				},
			},
		},
	},
})
