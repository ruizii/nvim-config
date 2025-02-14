return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		local function lsp_name()
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return ""
			end

			local names = {}
			for _, client in pairs(clients) do
				table.insert(names, client.name)
			end

			return " " .. table.concat(names, " ")
		end
		require("lualine").setup({
			options = {
				theme = "ayu_mirage",
				component_separators = { left = " ", right = " " },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = " " } } },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostics", { lsp_name }, "filetype" },
				lualine_y = { { "location", separator = { right = " " } } },
				lualine_z = { "progress" },
			},
		})
	end,
}
