-- Convenience
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n" }, "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set({ "x", "o" }, "<Leader>/", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "<C-s>", "<cmd>silent! update | redraw<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gc", "<nop>")
vim.keymap.set({ "i", "x" }, "<C-s>", "<ESC><cmd>silent! update | redraw<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>c", "<cmd>bdelete<CR>", { noremap = true })

-- Telescope
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>lua require('utils.telescope-fallback').project_files()<CR>",
	{ desc = "Find Files", remap = true }
)
vim.keymap.set("n", "<leader>f/", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", remap = true })
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

vim.keymap.set("n", "<C-t>", "<cmd>18sp +te<CR>")
vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:bd!<CR>", { noremap = true, silent = true })
