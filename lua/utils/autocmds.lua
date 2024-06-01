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

function M.load_lsp_keymaps()
	create_autocmd("LspAttach", {
		desc = "Configure lsp keymaps",
		pattern = "*",
		callback = function()
			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true })
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = true })
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = true })
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { buffer = true })
			vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { buffer = true })
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = true })
			vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = true })
			vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = true })
			vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = true })
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = true })
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = true })
		end,
	})
end

return M
