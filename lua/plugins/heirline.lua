return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "navarasu/onedark.nvim" },
	event = { "User FilePost" },
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = {
			bright_bg = "#31353f",
			bright_fg = "#abb2bf",
			yellow = "#e5c07b",
			red = "#e86671",
			dark_red = "#e86671",
			green = "#98c379",
			blue = "#61afef",
			gray = "#5c6370",
			orange = "#d19a66",
			purple = "#c678dd",
			cyan = "#61afef",
			diag_warn = "#e5c07b",
			diag_error = "#e86671",
			diag_hint = "#c678dd",
			diag_info = "#56b6c2",
			git_del = "#e86671",
			git_add = "#98c379",
			git_change = "#61afef",
		}
		require("heirline").load_colors(colors)

		local mode_names = {
			["!"] = "SHELL",
			["R"] = "REPLACE",
			["Rc"] = "REPLACE",
			["Rv"] = "V-REPLACE",
			["Rvc"] = "V-REPLACE",
			["Rvx"] = "V-REPLACE",
			["Rx"] = "REPLACE",
			["S"] = "S-LINE",
			["V"] = "V-LINE",
			["Vs"] = "V-LINE",
			["\19"] = "S-BLOCK",
			["\22"] = "V-BLOCK",
			["\22s"] = "V-BLOCK",
			["c"] = "COMMAND",
			["ce"] = "EX",
			["cv"] = "EX",
			["i"] = "INSERT",
			["ic"] = "INSERT",
			["ix"] = "INSERT",
			["n"] = "NORMAL",
			["niI"] = "NORMAL",
			["niR"] = "NORMAL",
			["niV"] = "NORMAL",
			["no"] = "O-PENDING",
			["noV"] = "O-PENDING",
			["no\22"] = "O-PENDING",
			["nov"] = "O-PENDING",
			["nt"] = "NORMAL",
			["ntT"] = "NORMAL",
			["r"] = "REPLACE",
			["r?"] = "CONFIRM",
			["rm"] = "MORE",
			["s"] = "SELECT",
			["t"] = "TERMINAL",
			["v"] = "VISUAL",
			["vs"] = "VISUAL",
		}

		local mode_colors = {
			NORMAL = "blue",
			INSERT = "green",
			VISUAL = "purple",
			["V-LINE"] = "purple",
			["V-BLOCK"] = "purple",
			COMMAND = "orange",
			SELECT = "purple",
			["S-LINE"] = "purple",
			["S-BLOCK"] = "purple",
			REPLACE = "red",
			MORE = "orange",
			SHELL = "red",
			TERMINAL = "blue",
		}

		local function GetModeName(mode)
			return mode_names[mode] or "???"
		end

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			provider = function(self)
				return GetModeName(self.mode) .. " "
			end,
			hl = function(self)
				local mode_name = GetModeName(self.mode)
				local mode_color = mode_colors[mode_name] or "bright_fg"
				return { fg = mode_color, bold = true }
			end,
			update = {
				"ModeChanged",
			},
		}

		local FileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
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
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "[No Name]"
				end
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
				provider = " ●",
				hl = { fg = "blue" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = " ",
				hl = { fg = "red" },
			},
		}

		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					-- use `force` because we need to override the child's hl foreground
					return { fg = "cyan", bold = true, force = true }
				end
			end,
		}

		local FileType = {
			provider = function()
				return vim.bo.filetype
			end,
			hl = { fg = "blue", bold = true },
		}

		local FileEncoding = {
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
				return enc ~= "utf-8" and enc:upper()
			end,
		}

		local FileSize = {
			provider = function()
				local suffix = { "b", "k", "M", "G", "T", "P", "E" }
				local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
				fsize = (fsize < 0 and 0) or fsize
				if fsize < 1024 then
					return string.format(" [%.2d%s]", fsize, suffix[1])
				end
				local i = math.floor((math.log(fsize) / math.log(1024)))
				return string.format(" [%.2g%s]", fsize / math.pow(1024, i), suffix[i + 1])
			end,
			hl = { fg = "blue" },
		}

		FileNameBlock = utils.insert(
			FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			FileFlags,
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = function()
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				if type(row) ~= "number" or type(col) ~= "number" then
					return ""
				end
				return "  " .. string.format("%2s:%2s", row, col + 1)
			end,
			-- provider = "%2s:%2s   %P",
		}

		local Progress = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			hl = function(self)
				local mode_name = GetModeName(self.mode)
				local mode_hl = mode_colors[mode_name] or mode_colors.NORMAL
				return { fg = mode_hl, bold = true }
			end,
			provider = function(self)
				local line_fraction = math.floor(vim.fn.line(".") / vim.fn.line("$") * 100)
				local value = string.format("%2d%%%%", line_fraction)
				if line_fraction <= 0 then
					value = "Top"
				elseif line_fraction >= 100 then
					value = "Bot"
				end
				return "  " .. value .. " "
			end,
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			provider = function()
				local names = {}
				---@diagnostic disable-next-line
				for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return "  " .. table.concat(names, ", ")
			end,
			hl = { fg = "green", bold = true },
		}

		local Diagnostics = {

			condition = conditions.has_diagnostics,

			static = {
				error_icon = " ",
				warn_icon = " ",
				hint_icon = "󰠠 ",
				info_icon = " ",
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

			hl = { fg = "bright_fg" },

			{ -- git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true },
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
		}
		local WorkDir = {
			provider = function()
				local icon = "󰉋 "
				local cwd = vim.fn.getcwd(0)
				cwd = vim.fn.fnamemodify(cwd, ":~")
				if not conditions.width_percent_below(#cwd, 0.25) then
					cwd = vim.fn.pathshorten(cwd)
				end
				local trail = cwd:sub(-1) == "/" and "" or "/"
				return icon .. cwd .. trail
			end,
			hl = { fg = "blue", bold = true },
		}
		local HelpFileName = {
			condition = function()
				return vim.bo.filetype == "help"
			end,
			provider = function()
				local filename = vim.api.nvim_buf_get_name(0)
				return vim.fn.fnamemodify(filename, ":t")
			end,
			hl = { fg = colors.blue },
		}

		local MacroRec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			provider = " ",
			hl = { fg = "orange", bold = true },
			utils.surround({ "[", "]" }, nil, {
				provider = function()
					return vim.fn.reg_recording()
				end,
				hl = { fg = "green", bold = true },
			}),
			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
		}

		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local DefaultStatusLine = {
			ViMode,
			Space,
			Space,
			FileNameBlock,
			FileSize,
			Space,
			Space,
			Git,
			Align,

			WorkDir,
			Align,

			Diagnostics,
			Space,
			LSPActive,
			Space,
			Space,
			FileType,
			Space,
			Ruler,
			Progress,
		}

		local InactiveStatusline = {
			condition = conditions.is_not_active,
			FileType,
			Space,
			FileName,
			Align,
		}

		local SpecialStatusLine = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile", "prompt", "help", "quickfix" },
					filetype = { "^git.*" },
				})
			end,

			FileType,
			Space,
			HelpFileName,
			Align,
		}

		local TerminalStatusLine = {
			condition = function()
				return conditions.buffer_matches({ buftype = { "terminal" } })
			end,
			hl = { bg = "none" },
			{ condition = conditions.is_active, ViMode, Space },
		}

		local StatusLines = {
			hl = function()
				if conditions.is_active() then
					return "StatusLine"
				else
					return "StatusLineNC"
				end
			end,

			-- the first statusline with no condition, or which condition returns true is used.
			-- think of it as a switch case with breaks to stop fallthrough.
			fallthrough = false,

			SpecialStatusLine,
			TerminalStatusLine,
			InactiveStatusline,
			DefaultStatusLine,
		}

		require("heirline").setup({
			statusline = StatusLines,
		})
	end,
}
