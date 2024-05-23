return {
	"CRAG666/code_runner.nvim",
	cmd = "RunCode",
	opts = {
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
	},
}
