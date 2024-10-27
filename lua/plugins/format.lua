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
			python = { "ruff_format" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "goimports", "gofmt" },
			sh = { "shfmt" },
			javascript = { "prettierd" },
			vue = { "prettierd" },
			html = { "prettierd" },
			typescript = { "prettierd" },
			php = { "php_cs_fixer" },
			rust = { "rustfmt" },
		},
		formatters = {
			["php_cs_fixer"] = {
				command = "php-cs-fixer",
				args = {
					"fix",
					"--config=" .. vim.fn.expand("$HOME/.php-cs-fixer.php"),
					"$FILENAME",
				},
				stdin = false,
			},
		},
	},
}
