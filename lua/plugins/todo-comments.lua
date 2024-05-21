return {
	"folke/todo-comments.nvim",
	lazy = true,
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	dependencies = "nvim-lua/plenary.nvim",
	opts = {},
}
