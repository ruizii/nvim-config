local leader_map = function()
	vim.g.mapleader = " "
end

local set_colorscheme = function()
	vim.cmd.colorscheme("neodark")
end

local load_core = function()
	leader_map()

	require("core.lazy")
	require("core.mappings")
	require("utils.highlight_yank")
	require("core.options")

	set_colorscheme()
end

load_core()
