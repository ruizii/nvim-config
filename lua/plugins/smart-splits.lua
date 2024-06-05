return {
	"mrjones2014/smart-splits.nvim",
	build = "./kitty/install-kittens.bash",
	keys = {
		{
			"<A-h>",
			function()
				require("smart-splits").resize_left()
			end,
			mode = "n",
		},
		{
			"<A-j>",
			function()
				require("smart-splits").resize_down()
			end,
			mode = "n",
		},
		{
			"<A-k>",
			function()
				require("smart-splits").resize_up()
			end,
			mode = "n",
		},
		{
			"<A-l>",
			function()
				require("smart-splits").resize_right()
			end,
			mode = "n",
		},
		{
			"<C-h>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			mode = "n",
		},
		{
			"<C-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			mode = "n",
		},
		{
			"<C-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			mode = "n",
		},
		{
			"<C-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			mode = "n",
		},
		{
			"<leader><leader>h",
			function()
				require("smart-splits").swap_buf_left()
			end,
			mode = "n",
		},
		{
			"<leader><leader>j",
			function()
				require("smart-splits").swap_buf_down()
			end,
			mode = "n",
		},
		{
			"<leader><leader>k",
			function()
				require("smart-splits").swap_buf_up()
			end,
			mode = "n",
		},
		{
			"<leader><leader>l",
			function()
				require("smart-splits").swap_buf_right()
			end,
			mode = "n",
		},
	},

	config = function()
		require("smart-splits").setup({
			multiplexer_integration = vim.env.KITTY_LISTEN_ON ~= nil and "kitty" or nil,
		})
	end,
}
