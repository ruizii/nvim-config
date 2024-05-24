-- Convenience
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "x", "o" }, "<Leader>/", "gcc", { remap = true })
vim.keymap.set("n", "<C-s>", "<cmd>silent! update | redraw<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gc", "<nop>")
vim.keymap.set({ "i", "x" }, "<C-s>", "<ESC><cmd>silent! update | redraw<CR>", { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bprev<CR>", { remap = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bnext<CR>", { remap = true })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<CR>", { noremap = true })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { remap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { remap = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { remap = true })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { remap = true })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { remap = true })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<CR>", { remap = true })

-- Code Runner
vim.keymap.set("n", "<F5>", "<cmd>RunCode<CR>", { noremap = true, silent = false })
