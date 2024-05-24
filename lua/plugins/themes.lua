return {
	{
		"navarasu/onedark.nvim",
		lazy = true,
		opts = {
			transparent = true,
			style = "dark",
			highlights = {
				DiagnosticVirtualTextOk = { fg = "#b3f6c0", bg = "Normal" },
				DiagnosticVirtualTextHint = { fg = "#c678dd", bg = "Normal" },
				DiagnosticVirtualTextInfo = { fg = "#56b6c2", bg = "Normal" },
				DiagnosticVirtualTextWarn = { fg = "#e5c07b", bg = "Normal" },
				DiagnosticVirtualTextError = { fg = "#e86671", bg = "Normal" },

				LspDiagnosticsVirtualTextHint = { fg = "#c678dd", bg = "Normal" },
				LspDiagnosticsVirtualTextInformation = { fg = "#56b6c2", bg = "Normal" },
				LspDiagnosticsVirtualTextWarning = { fg = "#e5c07b", bg = "Normal" },
				LspDiagnosticsVirtualTextError = { fg = "#e86671", bg = "Normal" },
			},
		},
	},
	{
		"diegoulloao/neofusion.nvim",
		lazy = true,
		opts = {
			transparent_mode = true,
		},
	},
}
