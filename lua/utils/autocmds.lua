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
	desc = "Close some filetypes with <q>",
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"qf",
		"query",
		"startuptime",
		"checkhealth",
	},
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

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

---- WSL Cursor Shape Fix ----
autocmd("VimLeave", {
	callback = function()
		local is_wsl = os.getenv("WSL_DISTRO_NAME") or "not wsl"

		if vim.fn.has("win32") == 1 or is_wsl ~= "not wsl" then
			vim.opt.guicursor = "a:ver25"
		end
	end,
})
