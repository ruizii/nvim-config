return {
	"CRAG666/code_runner.nvim",
	dependencies = {
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "RunCode", "RunFile", "RunProject" },
		keys = { "<C-t>" },
		opts = {
			open_mapping = [[<C-t>]],
			hide_numbers = true,
			autochdir = true,
			insert_mappings = true,
			shade_terminals = false,
			close_on_exit = false,
		},
	},
	cmd = { "RunCode", "RunFile", "RunProject" },
	config = function()
		require("code_runner").setup({
			mode = "toggleterm",
			startinsert = true,
			term = {
				size = 15,
			},
			filetype = {
				python = "python -u",
				javascript = "node",
				cpp = "cd $dir && make && $dir/$fileNameWithoutExt",
				c = "cd $dir && make && $dir/$fileNameWithoutExt",
				go = "go run",
				sh = "bash",
				asm = "nasm -f elf64 $fileName && ld $fileNameWithoutExt.o -o $fileNameWithoutExt && ./$fileNameWithoutExt",
				lua = "lua",
			},
		})
	end,
}
