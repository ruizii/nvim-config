local map = vim.keymap.set

-- Convenience
map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight on esc", noremap = true })
map({ "n" }, "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
map({ "x", "o" }, "<Leader>/", "gc", { desc = "Toggle comment", remap = true })
map("n", "<C-s>", "<cmd>write | redraw<CR>", { noremap = true, silent = true })
map("n", "gc", "<nop>", { desc = "Unmap gc" })
map("n", "c", '"_c', { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })

map("n", "<leader>c", "<cmd>close<CR>", { desc = "Close window", noremap = true })
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("n", "H", "<nop>")
map("n", "L", "<nop>")
map("n", "J", "<nop>")

-- Telescope
map("n", "<leader>fe", "<cmd>Telescope git_files<CR>", { desc = "Git Files", noremap = true })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files", noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep", noremap = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help files", noremap = true })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files", noremap = true })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todo", noremap = true })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers({
		sort_mru = true,
		show_all_buffers = false,
	})
end, { desc = "Buffers", noremap = true })

-- Terminal normal mode
map("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })
