return {
	"folke/todo-comments.nvim",
	lazy = true,
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	dependencies = "nvim-lua/plenary.nvim",
	opts = {},
}
