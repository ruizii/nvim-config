return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost" },
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local colors = {
			red = "#e06c75",
			green = "#98c379",
			blue = "#61afef",
			gray1 = "#828997",
			gray2 = "#2c323c",
			gray3 = "#3e4452",
			yellow = "#e5c07b",
			purple = "#c678dd",
			cyan = "#56b6c2",

			git_add = "#98c379",
			git_del = "#e06c75",
			git_change = "#56b6c2",

			diag_warn = "#e5c07b",
			diag_error = "#e06c75",
			diag_hint = "#c678dd",
			diag_info = "#61afef",

			bright_fg = "#abb2bf",
			bright_bg = "#282c34",
		}

		require("heirline").load_colors(colors)

		--- @param hl_tbl table | nil
		--- @return table
		local function make_hl(hl_tbl)
			local base_hl = { bg = "none", fg = "bright_fg" }

			if not hl_tbl then
				return base_hl
			end

			return vim.tbl_deep_extend("force", base_hl, hl_tbl)
		end

		local ViMode = {
			static = {
				mode_names = {
					-- change the strings if you like it vvvvverbose!
					n = "NORMAL",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "VISUAL",
					vs = "Vs",
					V = "VISUAL",
					Vs = "Vs",
					["\22"] = "VISUAL",
					["\22s"] = "VISUAL",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "INSERT",
					ic = "Ic",
					ix = "Ix",
					R = "REPLACE",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "COMMAND",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "TERMINAL",
				},
				mode_colors = {
					n = "blue",
					i = "yellow",
					v = "purple",
					V = "purple",
					["\22"] = "purple",
					c = "green",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "red",
					r = "red",
					["!"] = "red",
					t = "blue",
				},
			},
			provider = function(self)
				return " " .. self.mode_names[self.mode]
			end,
			init = function(self)
				self.mode = vim.fn.mode()
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true }
			end,

			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		local FilenameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, " ")
			end,
			hl = { fg = "bright_fg", bold = true },
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				-- first, trim the pattern relative to the current directory. For other
				-- options, see :h filename-modifers
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "[No Name]"
				end
				-- now, if the filename would occupy more than 1/4th of the available
				-- space, we trim the file path to its initials
				-- See Flexible Components section below for dynamic truncation
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = "cyan" },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " ● ",
				hl = { fg = "green" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "  ",
				hl = { fg = "red" },
			},
		}
		local FilenameModifier = {
			hl = function()
				if vim.bo.modified then
					return { fg = "cyan", bold = true, force = true }
				end
			end,
		}

        -- stylua: ignore
        FilenameBlock = utils.insert(
            FilenameBlock,
            FileIcon,
            utils.insert(FilenameModifier, FileName),
            FileFlags,
            { provider = "%<"}
        )

		local FileType = {
			provider = function()
				return "   " .. vim.bo.filetype
			end,
			hl = { fg = "blue" },
		}

		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = "%6(%l:%2c%)",
			hl = make_hl(),
		}

		local ScrollBar = {
			static = {
				-- Another variant, because the more choice the better.
				sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return string.rep(self.sbar[i], 2) .. " %P"
			end,
			hl = { fg = "diag_hint", bg = "none" },
		}
		local Diagnostics = {

			condition = conditions.has_diagnostics,

			static = {
				error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = "diag_error" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = "diag_warn" },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = "diag_info" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = "diag_hint" },
			},
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = "gray1" },

			{ -- git branch name
				provider = function(self)
					return "  " .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_del" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("  " .. count)
				end,
				hl = { fg = "git_change" },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
			},
		}

		local Align = { provider = "%=", hl = make_hl() }
		local Space = { provider = " ", hl = make_hl() }

		local LeftBlock = { ViMode, Space, Space, FilenameBlock, Space, Space, Git }
		local RightBlock = {
			Diagnostics,
			Space,
			Space,
			LSPActive,
			Space,
			FileType,
			Space,
			Space,
			Ruler,
			Space,
			Space,
			ScrollBar,
		}

		local StatusLine = {
			LeftBlock,
			Align,
			Align,
			RightBlock,
		}

		local heirline = require("heirline")
		heirline.setup({
			statusline = { StatusLine },
		})
	end,
}
