vim.api.nvim_create_augroup("userconfig", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	group = "userconfig",
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

autocmd("BufWinEnter", {
	group = "userconfig",
	desc = "Open file in last position",
	pattern = "*",
	command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

autocmd("BufWritePre", {
	group = "userconfig",
	desc = "Remove whitespaces on save",
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

autocmd("Filetype", {
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

autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

vim.cmd([[
    augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 3 0 3
]])

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

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
			end)
		end
	end,
})
