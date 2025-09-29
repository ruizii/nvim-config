return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = false,
		},

		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			go = { "goimports", "gofmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			python = { "isort", "ruff_format" },
			sh = { "shfmt" },
			rust = { "rustfmt" },
		},

		formatters = {
			shfmt = {
				prepend_args = { "-ci" },
			},
		},
	},
}
