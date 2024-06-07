vim.api.nvim_create_augroup("userconfig", {})
vim.api.nvim_create_augroup("NvFilePost", {})

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

autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true })
		vim.keymap.set(
			"n",
			"gd",
			"<cmd>Telescope lsp_definitions<cr>",
			{ desc = "Show lsp definitions", buffer = true }
		)
		vim.keymap.set(
			"n",
			"gD",
			"<cmd>lua vim.lsp.buf.declaration()<cr>",
			{ desc = "Go to declaration", buffer = true }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>la",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			{ desc = "Code actions", buffer = true }
		)
		vim.keymap.set(
			"n",
			"gi",
			"<cmd>Telescope lsp_implementations<cr>",
			{ desc = "Show lsp implementations", buffer = true }
		)
		vim.keymap.set(
			"n",
			"go",
			"<cmd>Telescope lsp_type_definitions<cr>",
			{ desc = "Show lsp type definitions", buffer = true }
		)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = true })
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = true })
		vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Lsp rename", buffer = true })
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = true })
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = true })
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = true })
	end,
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

vim.cmd([[
    augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
    au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 3 0 3
]])

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = "NvFilePost",
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
