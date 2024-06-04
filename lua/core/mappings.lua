-- Convenience
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n" }, "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set({ "x", "o" }, "<Leader>/", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "<C-s>", "<cmd>silent! update | redraw<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gc", "<nop>")
vim.keymap.set({ "i", "x" }, "<C-s>", "<ESC><cmd>silent! update | redraw<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "c", '"_c', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>c", "<cmd>close<CR>", { desc = "Close window", noremap = true })
vim.keymap.set("n", "<leader><leader>", "<C-6>", { desc = "Toggle last and current buffers" })

-- Telescope
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>lua require('utils.telescope-fallback').project_files()<CR>",
	{ desc = "Find Files", remap = true }
)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics", remap = true })
vim.keymap.set(
	"n",
	"<leader>fs",
	"<cmd>Telescope lsp_document_symbols<CR>",
	{ desc = "Document symbols", remap = true }
)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", remap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help files", remap = true })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files", remap = true })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", remap = true })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Change directory", remap = true })
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		show_all_buffers = false,
	})
end, { desc = "Buffers", remap = true })

vim.api.nvim_set_keymap("t", "<esc><esc>", "<C-\\><C-n><CR>", { noremap = true, silent = true })
