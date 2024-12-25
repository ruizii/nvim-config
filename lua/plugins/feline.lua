return {
	"freddiehaddad/feline.nvim",
	event = "User FilePost",
	config = function()
		local line_ok, feline = pcall(require, "feline")
		if not line_ok then
			return
		end

		local one_monokai = {
			fg = "#abb2bf",
			bg = "NONE",
			green = "#98c379",
			yellow = "#e5c07b",
			purple = "#c678dd",
			orange = "#d19a66",
			peanut = "#f6d5a4",
			red = "#e06c75",
			aqua = "#4DC4FF",
			darkblue = "#282c34",
			dark_red = "#f75f5f",
			glow = "#1BFD9C", -- Just in case
		}

		local vi_mode_colors = {
			NORMAL = "aqua",
			OP = "aqua",
			INSERT = "green",
			VISUAL = "purple",
			LINES = "purple",
			BLOCK = "purple",
			REPLACE = "red",
			COMMAND = "aqua",
		}

		local c = {
			vim_mode = {
				provider = {
					name = "vi_mode",
					opts = {
						show_mode_name = true,
						-- padding = "center", -- Uncomment for extra padding.
					},
				},
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "NONE",
						style = "bold",
						name = require("feline.providers.vi_mode").get_mode_highlight_name(),
					}
				end,
				left_sep = " ",
				right_sep = " ",
			},
			gitBranch = {
				provider = "git_branch",
				hl = {
					fg = "fg",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffAdded = {
				provider = "git_diff_added",
				hl = {
					fg = "green",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffRemoved = {
				provider = "git_diff_removed",
				hl = {
					fg = "red",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffChanged = {
				provider = "git_diff_changed",
				hl = {
					fg = "aqua",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			nvim_macro = {
				provider = "macro",
				hl = {
					fg = "red",
				},
			},
			separator = {
				provider = "",
			},
			fileinfo = {
				provider = {
					name = "file_info",
					opts = {
						type = "relative",
					},
				},
				hl = {
					fg = "aqua",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			diagnostic_errors = {
				provider = "diagnostic_errors",
				hl = {
					fg = "red",
				},
				left_sep = " ",
				right_sep = " ",
			},
			diagnostic_warnings = {
				provider = "diagnostic_warnings",
				hl = {
					fg = "yellow",
				},
				left_sep = " ",
				right_sep = " ",
			},
			diagnostic_hints = {
				provider = "diagnostic_hints",
				hl = {
					fg = "aqua",
				},
				left_sep = " ",
				right_sep = " ",
			},
			diagnostic_info = {
				provider = "diagnostic_info",
				left_sep = " ",
				right_sep = " ",
			},
			lsp_client_names = {
				provider = "lsp_client_names",
				hl = {
					fg = "fg",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			file_type = {
				provider = {
					name = "file_type",
					opts = {
						filetype_icon = true,
						case = "lowercase",
					},
				},
				hl = {
					fg = "aqua",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			position = {
				provider = "position",
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "NONE",
						name = require("feline.providers.vi_mode").get_mode_highlight_name(),
					}
				end,
				left_sep = " ",
				right_sep = " ",
			},
			line_percentage = {
				provider = "line_percentage",
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "NONE",
						name = require("feline.providers.vi_mode").get_mode_highlight_name(),
					}
				end,
				left_sep = " ",
				right_sep = " ",
			},
			scroll_bar = {
				provider = "scroll_bar",
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "NONE",
						name = require("feline.providers.vi_mode").get_mode_highlight_name(),
					}
				end,
			},
		}

		local left = {
			c.vim_mode,
			c.nvim_macro,
			c.gitBranch,
			c.gitDiffAdded,
			c.gitDiffRemoved,
			c.gitDiffChanged,
			c.separator,
		}

		local middle = {
			c.fileinfo,
		}

		local right = {
			c.diagnostic_errors,
			c.diagnostic_warnings,
			c.diagnostic_info,
			c.diagnostic_hints,
			c.lsp_client_names,
			c.file_type,
			c.position,
			c.line_percentage,
			c.scroll_bar,
		}

		local components = {
			active = {
				left,
				middle,
				right,
			},
			inactive = {
				left,
				middle,
				right,
			},
		}

		feline.setup({
			components = components,
			theme = one_monokai,
			vi_mode_colors = vi_mode_colors,
		})
	end,
}
