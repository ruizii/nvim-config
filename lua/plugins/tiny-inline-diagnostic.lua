return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "ghost",
			transparent_bg = true,
			options = {
				multilines = {
					enabled = true,
					always_show = true,
				},
				break_line = {
					enabled = true,
					after = 60,
				},
			},
		})
	end,
}
