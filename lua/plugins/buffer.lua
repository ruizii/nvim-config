return {
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
		enabled = true,
		init = function()
			vim.keymap.set(
				"n",
				"<leader>c",
				"<cmd>Bdelete<CR>",
				{ noremap = true, silent = true, desc = "Delete buffer" }
			)
		end,
	},
}
