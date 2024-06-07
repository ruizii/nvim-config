local load_colorscheme = function(colorscheme)
	vim.api.nvim_command(string.format("colorscheme %s", colorscheme))
	require("utils.transparent")
end

local load_core = function()
	vim.g.mapleader = " "
	leader_map()
	require("utils.autocmds")
	require("core.options")
	require("core.mappings")
	require("core.lazy")
	load_colorscheme("onedark")
	load_utils()
end

load_core()
