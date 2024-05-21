return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		lazy = true,
		event = { "InsertEnter" },
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				lazy = true,
			},
			{
				"saadparwaiz1/cmp_luasnip",
				lazy = true,
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				lazy = true,
			},
			{
				"hrsh7th/cmp-path",
				lazy = true,
			},
			{
				"hrsh7th/cmp-nvim-lsp-signature-help",
				lazy = true,
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = require("cmp.config.compare")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Select the [n]ext item
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					-- Select the [p]revious item
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<C-n>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				window = {
					completion = {
						border = "single",
					},
					documentation = {
						border = "single",
					},
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.offset,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
			})
		end,
	},
}
