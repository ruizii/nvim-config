local map = vim.keymap.set

-- Convenience
map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight on esc", noremap = true })
map({ "n" }, "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
map({ "x", "o" }, "<Leader>/", "gc", { desc = "Toggle comment", remap = true })
map("n", "gc", "<nop>", { desc = "Unmap gc" })
map("n", "c", '"_c', { noremap = true, silent = true })

map("n", "<leader>c", "<cmd>close<CR>", { desc = "Close window", noremap = true })
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Telescope
map(
	"n",
	"<leader>ff",
	"<cmd>lua require('utils.telescope-fallback').project_files()<CR>",
	{ desc = "Find Files", noremap = true }
)
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics", noremap = true })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols", noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", noremap = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help files", noremap = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files", noremap = true })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", noremap = true })
map("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { desc = "Change directory", noremap = true })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		show_all_buffers = false,
	})
end, { desc = "Buffers", noremap = true })

-- Terminal normal mode
map("t", "<esc><esc>", "<C-\\><C-n><CR>", { noremap = true, silent = true })
