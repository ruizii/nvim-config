return {
	"CRAG666/code_runner.nvim",
	keys = {
		{
			"<F5>",
			"<cmd>RunCode<cr>",
			desc = "Run code",
		},
	},
	cmd = "RunCode",
	config = function()
		require("code_runner").setup({
			mode = "term",
			startinsert = true,
			focus = true,
			term = {
				size = 18,
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
