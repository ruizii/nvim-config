local opts_extend = require("utils.helpers").opts_extend

local M = {}

function M.smart_dd()
	local dd = function()
		if vim.api.nvim_get_current_line():match("^%s*$") then
			return '"_dd'
		else
			return "dd"
		end
	end
	vim.keymap.set("n", "dd", dd, { noremap = true, expr = true })
end

function M.visual_codeblock_shift()
	vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
end

function M.ctrl_backspace_delete(opts)
	opts = opts_extend({ cmd_mode = true, insert_mode = true }, opts)
	if opts.insert_mode then
		vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", { noremap = true })
	end
	if opts.cmd_mode then
		vim.api.nvim_set_keymap("c", "<C-BS>", "<C-w>", { noremap = true })
	end
end

return M
