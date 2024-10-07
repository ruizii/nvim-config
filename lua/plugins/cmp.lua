return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
			"onsails/lspkind.nvim",
			"honza/vim-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local lspkind = require("lspkind")
			local snippy = require("snippy")
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

	                snippy.setup({
                            mappings = {
	                        is = {
	                            ["<Tab>"] = "expand_or_advance",
	                            ["<S-Tab>"] = "previous",
	                        },
			    },
            	        })

			vim.g.cmp_toggle = true
			cmp.setup({
				enabled = function()
					return vim.g.cmp_toggle
				end,
				snippet = {
					expand = function(args)
						snippy.expand_snippet(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "snippy" },
					{ name = "path" },
					{ name = "buffer" },
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
						symbol_map = {
							Function = "λ",
						},
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
					}),
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
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
}
