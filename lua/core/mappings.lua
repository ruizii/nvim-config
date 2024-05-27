-- Convenience
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "x", "o" }, "<Leader>/", "gcc", { remap = true })
vim.keymap.set("n", "<C-s>", "<cmd>silent! update | redraw<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gc", "<nop>")
vim.keymap.set({ "i", "x" }, "<C-s>", "<ESC><cmd>silent! update | redraw<CR>", { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { remap = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { remap = true })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<CR>", { noremap = true })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files", remap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", remap = true })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files", remap = true })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", remap = true })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Change Directory", remap = true })
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		ignore_current_buffer = true,
		show_all_buffers = false,
	})
end, { desc = "Buffers", remap = true })

-- Code Runner
vim.keymap.set("n", "<F5>", "<cmd>RunCode<CR>", { noremap = true, silent = false })

-- Lsp
vim.keymap.set("n", "<leader>la", function()
	vim.lsp.buf.code_action()
end)
