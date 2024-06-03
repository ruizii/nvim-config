local utils = require("utils.create-autocmd")
local create_autocmd = utils.create_autocmd

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

create_autocmd("BufWinEnter", {
	desc = "Open file in last position",
	pattern = "*",
	command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

create_autocmd("BufWritePre", {
	desc = "Remove whitespaces on save",
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

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

create_autocmd("TermOpen", {
	desc = "Disable line numbers on terminal",
	pattern = "*",
	callback = function()
		vim.api.nvim_command("startinsert")
		vim.api.nvim_command("setlocal nonumber norelativenumber signcolumn=no winheight=16")
	end,
})

create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end, 0)
		end
	end,
})
