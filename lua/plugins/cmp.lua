return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			{
				"windwp/nvim-autopairs",
				config = function()
					local autopairs = require("nvim-autopairs")
					autopairs.setup({
						check_ts = true,
						ts_config = {
							lua = { "string" },
							javascript = { "template_string" },
							java = false,
						},
					})

					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					local cmp = require("cmp")
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local lspkind = require("lspkind")

			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "path", priority = 500 },
				}, {
					{ name = "buffer", priority = 250 },
				}),
				window = {
					completion = {
						border = "single",
					},
					documentation = {
						border = "single",
					},
				},
				sorting = defaults.sorting,
				---@diagnostic disable-next-line
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						menu = {
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[Path]",
						},
					}),
				},
			})
		end,
	},
	{
		"garymjr/nvim-snippets",
		keys = {
			{
				"<Tab>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<Tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<S-Tab>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
}
