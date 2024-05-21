local leader_map = function()
	vim.g.mapleader = " "
end

local load_utils = function()
	local autocmds = require("utils.autocmds")
	local mappings = require("utils.mappings")

	local commands = vim.tbl_extend("force", autocmds, mappings)

	for _, value in pairs(commands) do
		value()
	end
end

local load_colorscheme = function(colorscheme)
	vim.api.nvim_command(string.format("colorscheme %s", colorscheme))
end

local load_core = function()
	leader_map()
	require("core.options")
	require("core.mappings")
	require("core.lazy")
	load_colorscheme("onedark")
	load_utils()
end

load_core()
