return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<C-b>",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
		},
	},

	config = function()
		local function set_highlights()
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { link = "Identifier", bg = nil, bold = true })
			vim.api.nvim_set_hl(0, "NeoTreeMiniIconsAzure", { link = "Identifier", bg = nil, bold = true })
		end
		set_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("NeoTreeHighlights", { clear = true }),
			callback = set_highlights,
		})

		require("neo-tree").setup({
			window = {
				mappings = {
					["<C-b>"] = "close_window",
				},
			},
			default_component_configs = {
				icon = {
					provider = function(icon, node) -- setup a custom icon provider
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then -- if it's a file, set the text/hl
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then -- get directory icons
							text, hl = mini_icons.get("directory", node.name)
							-- only set the icon text if it is not expanded
							if node:is_expanded() then
								text = nil
							end
						end

						-- set the icon text/highlight only if it exists
						if text then
							icon.text = text
						end
						if hl then
							-- Scope the Azure override to neo-tree instead of changing MiniIconsAzure globally
							icon.highlight = hl == "MiniIconsAzure" and "NeoTreeMiniIconsAzure" or hl
						end
					end,
				},
				kind_icon = {
					provider = function(icon, node)
						local mini_icons = require("mini.icons")
						icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
					end,
				},
			},
		})
	end,
}
