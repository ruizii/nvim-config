return {
	"goolord/alpha-nvim",
	event = { "VimEnter" },
	init = false,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                    ]],
			[[                    ]],
			[[                    ]],
			[[                    ]],
			[[   🇦  🇸  🇩  🇫   ]],
			[[                    ]],
			[[                    ]],
			[[                    ]],
			[[                    ]],
		}

		local sep = " "

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈢" .. sep .. " File Browser", function()
				require("utils.telescope-fallback").project_files()
			end),
			dashboard.button("n", "󰈔" .. sep .. " New File", "<Cmd>ene <BAR><CR>"),
			dashboard.button("r", "" .. sep .. " Recent Files", "<Cmd>Telescope oldfiles<CR>"),
			dashboard.button("g", "󰈞" .. sep .. " Grep Files", ":Telescope live_grep<CR>"),
			dashboard.button("p", "󰉓" .. sep .. " Projects", "<Cmd>Telescope project<CR>"),
			dashboard.button("z", "󱧮" .. sep .. " Change Directory", "<Cmd>Telescope zoxide list<CR>"),
			dashboard.button("q", "󰅙" .. sep .. " Quit", "<Cmd>qa<CR>"),
		}

		dashboard.section.footer.opts.hl = "Normal"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"
		dashboard.opts.opts.noautocmd = true

		alpha.setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val = "\n \n \n \n \n"
					.. "Loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
