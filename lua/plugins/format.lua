return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = false,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "goimports", "gofmt" },
			sh = { "shfmt" },
			javascript = { "prettierd" },
			vue = { "prettierd" },
			html = { "prettierd" },
			typescript = { "prettierd" },
			rust = { "rustfmt" },
		},
	},
}
