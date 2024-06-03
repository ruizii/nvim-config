local utils = require("utils.create-autocmd")
local create_autocmd = utils.create_autocmd

vim.api.nvim_create_augroup("userconfig", { clear = true })

create_autocmd("TextYankPost", {
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

create_autocmd("BufWinEnter", {
	group = "userconfig",
	desc = "Open file in last position",
	pattern = "*",
	command = [[ if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
})

create_autocmd("BufWritePre", {
	group = "userconfig",
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
	group = "userconfig",
	desc = "Disable line numbers on terminal",
	pattern = "*",
	callback = function()
		vim.api.nvim_command("startinsert")
		vim.api.nvim_command("setlocal nonumber norelativenumber signcolumn=no winheight=16")
	end,
})

create_autocmd("LspAttach", {
	group = "userconfig",
	desc = "Load keymappings to buffer on lsp attach",
	pattern = "*",
	callback = function()
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true })
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = true })
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = true })
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { buffer = true })
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { buffer = true })
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = true })
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = true })
		vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Lsp rename", buffer = true })
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = true })
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = true })
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = true })
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
