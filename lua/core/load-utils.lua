local autocmds = require("utils.autocmds")
local mappings = require("utils.mappings")

local commands = vim.tbl_extend("force", autocmds, mappings)

local M = {}

M.load_utils = function()
	for _, value in pairs(commands) do
		value()
	end
end

return M
