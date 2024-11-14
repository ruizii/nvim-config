return {
	{

		"navarasu/onedark.nvim",
		lazy = true, -- Currently using default theme
		priority = 1000,
		opts = {
			style = "dark",
			highlights = {
				DiagnosticVirtualTextOk = { fg = "#b3f6c0", bg = "none" },
				DiagnosticVirtualTextHint = { fg = "#c678dd", bg = "none" },
				DiagnosticVirtualTextInfo = { fg = "#56b6c2", bg = "none" },
				DiagnosticVirtualTextWarn = { fg = "#e5c07b", bg = "none" },
				DiagnosticVirtualTextError = { fg = "#e86671", bg = "none" },

				LspDiagnosticsVirtualTextHint = { fg = "#c678dd", bg = "none" },
				LspDiagnosticsVirtualTextInformation = { fg = "#56b6c2", bg = "none" },
				LspDiagnosticsVirtualTextWarning = { fg = "#e5c07b", bg = "none" },
				LspDiagnosticsVirtualTextError = { fg = "#e86671", bg = "none" },
			},
			lualine = {
				transparent = true,
			},
		},
	},
	{
		"wnkz/monoglow.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
