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

function M.close_help_on_q()
	create_autocmd("Filetype", {
		group = "userconfig",
		desc = "keymap 'q' to close help/quickfix/netrw/etc windows",
		pattern = "help,qf,netrw",
		callback = function()
			vim.keymap.set(
				"n",
				"q",
				"<C-w>c",
				{ buffer = true, desc = "Quit (or Close) help, quickfix, netrw, etc windows" }
			)
		end,
	})
end

function M.disable_lnum_on_terminal()
	create_autocmd("TermOpen", {
		desc = "Disable line numbers on terminal",
		pattern = "*",
		callback = function()
			vim.api.nvim_command("startinsert")
			vim.api.nvim_command("setlocal nonumber norelativenumber signcolumn=no winheight=16")
		end,
	})
end

return M
