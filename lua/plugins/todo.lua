return {
	"Ackeraa/todo.nvim",
	cmd = "Todo",
	config = function()
		require("todo").setup({
			opts = {
				file_path = "/home/asdf/.config/nvim/todolist.txt",
			},
		})
	end,
}
