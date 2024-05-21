return {
	"goolord/alpha-nvim",
	lazy = true,
	event = { "VimEnter" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- { == Configuration ==> =====================================================

		dashboard.section.header.val = {
			[[                    ]],
			[[                    ]],
			[[   🇦  🇸  🇩  🇫   ]],
			[[                    ]],
		}

		local sep = " "
		dashboard.section.buttons.val = {
			-- dashboard.button("f", icons.Files .. sep .. "Files", ":Telescope find_files<CR>"),
			dashboard.button("f", "󰈢" .. sep .. " File Browser", "<Cmd>Neotree float<CR>"),
			dashboard.button("n", "󰈔" .. sep .. " New File", "<Cmd>ene <BAR> startinsert<CR>"),
			dashboard.button("r", "" .. sep .. " Recent Files", "<Cmd>Telescope oldfiles<CR>"),
			dashboard.button("p", "󰉓" .. sep .. " Projects", "<Cmd>Telescope projects<CR>"),
			dashboard.button("s", "" .. sep .. " Sessions", "<Cmd>SessionManager load_session<cr>"),
			dashboard.button("o", "" .. sep .. " Options", "<Cmd>e ~/.config/nvim/lua/nxvim/options.lua<CR>"),
			dashboard.button("q", "󰅙" .. sep .. " Quit", "<Cmd>qa<CR>"),
			-- dashboard.button("b", icons.Book .. sep .. " Bookmarks", ":Telescope bookmarks list prompt_title=Bookmarks<CR>"),
			-- dashboard.button("g", icons.List .. sep .. " Grep Files", ":Telescope live_grep <CR>"),
		}

		---@param kind "custom"|"fortune"
		local function footer(kind)
			if kind == "custom" then
				dashboard.section.footer.val = "\n \n \n" .. "gay."
				return
			end
		end
		footer("custom")

		dashboard.section.footer.opts.hl = "Normal"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"
		dashboard.opts.opts.noautocmd = true
		-- <== }

		alpha.setup(dashboard.opts)
		-- <== }
	end,
}
