local M = {}
local utils = require("utils.create-autocmd")
local create_autocmd = utils.create_autocmd

function M.highlight_on_yank()
	create_autocmd("TextYankPost", {
		desc = "Highlight text on yank",
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "Search",
				timeout = 150,
				on_visual = true,
			})
		end,
	})
end

function M.open_file_last_position()
	create_autocmd("BufWinEnter", {
		desc = "Open file in last position",
		pattern = "*",
		command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
	})
end

function M.remove_whitespace_on_save()
	create_autocmd("BufWritePre", {
		desc = "Remove whitespaces on save",
		pattern = "*",
		command = "%s/\\s\\+$//e",
	})
end

return M
