-- Convenience
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight on esc", noremap = true })
vim.keymap.set({ "n" }, "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set({ "x", "o" }, "<Leader>/", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "gc", "<nop>", { desc = "Unmap gc" })
vim.keymap.set("n", "c", '"_c', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>c", "<cmd>close<CR>", { desc = "Close window", noremap = true })
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Telescope
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>lua require('utils.telescope-fallback').project_files()<CR>",
	{ desc = "Find Files", noremap = true }
)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics", noremap = true })
vim.keymap.set(
	"n",
	"<leader>fs",
	"<cmd>Telescope lsp_document_symbols<CR>",
	{ desc = "Document symbols", noremap = true }
)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help files", noremap = true })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files", noremap = true })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", noremap = true })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Change directory", noremap = true })
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		show_all_buffers = false,
	})
end, { desc = "Buffers", noremap = true })

-- Terminal normal mode
vim.api.nvim_set_keymap("t", "<esc><esc>", "<C-\\><C-n><CR>", { noremap = true, silent = true })
