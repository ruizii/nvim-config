return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- REQUIRED
		require("harpoon"):setup()
		-- REQUIRED
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add to harpoon list",
		},

		{
			"<leader>e",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle quick menu",
		},

		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Harpoon to buffer 1",
		},
		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Harpoon to buffer 2",
		},
		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Harpoon to buffer 3",
		},
		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Harpoon to buffer 4",
		},

		-- Toggle previous & next buffers stored within Harpoon list
		{
			"<Tab>",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Harpoon to next buffer",
		},
		{
			"<S-Tab>",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Harpoon to previous buffer",
		},
	},
}
