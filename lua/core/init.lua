local leader_map = function()
	vim.g.mapleader = " "
end

local set_colorscheme = function(colorscheme)
	vim.api.nvim_command(string.format("colorscheme %s", colorscheme))
end

local load_core = function()
	leader_map()
	require("core.options")
	require("core.mappings")
	require("core.lazy")

	set_colorscheme("onedark")
end

load_core()
