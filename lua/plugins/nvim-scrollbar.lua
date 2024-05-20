return {
	"petertriho/nvim-scrollbar",
	event = "User AstroFile",
	config = function()
		require("scrollbar").setup({
			handle = {
				color = "#60606f",
			},
			marks = {
				Cursor = {
					text = "-",
				},
				Search = {
					color = "#FFEA00",
				},
			},
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				handle = true,
				search = false, -- Requires hlslens
				ale = false, -- Requires ALE
			},
		})
	end,
}
