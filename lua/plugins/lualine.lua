return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons", "abeldekat/harpoonline" },
	config = function()
		local Harpoonline = require("harpoonline")
		Harpoonline.setup({
			icon = "",
			on_update = function()
				require("lualine").refresh()
			end,
		})
		local lualine_c = { Harpoonline.format, "filename" }
		require("lualine").setup({
			sections = {
				lualine_c = lualine_c,
			},
			options = {
				theme = "onedark",
			},
		})
	end,
}
