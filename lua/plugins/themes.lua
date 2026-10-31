return {
	{

		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd.colorscheme("onedark")
		end,
		opts = {
			style = "dark",
			highlights = {
				DiagnosticVirtualTextOk = { fg = "#b3f6c0", bg = "none" },
				DiagnosticVirtualTextHint = { fg = "#c678dd", bg = "none" },
				DiagnosticVirtualTextInfo = { fg = "#56b6c2", bg = "none" },
				DiagnosticVirtualTextWarn = { fg = "#e5c07b", bg = "none" },
				DiagnosticVirtualTextError = { fg = "#e86671", bg = "none" },
			},
		},
	},
	{
		"wnkz/monoglow.nvim",
		opts = {},
	},
}
