return {
	"knubie/vim-kitty-navigator",
	lazy = false,
	cond = function()
		local is_kitty = os.getenv("KITTY_WINDOW_ID") or "not kitty"
		return is_kitty ~= "not kitty"
	end,
	init = function()
		vim.g.kitty_navigator_no_mappings = 1

		vim.keymap.set("n", "<c-h>", "<cmd>KittyNavigateLeft<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<c-j>", "<cmd>KittyNavigateDown<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<c-k>", "<cmd>KittyNavigateUp<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<c-l>", "<cmd>KittyNavigateRight<cr>", { noremap = true, silent = true })
	end,
}
