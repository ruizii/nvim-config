return {
	"CRAG666/code_runner.nvim",
	cmd = { "RunCode", "RunFile", "RunProject" },
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
				c = function(...)
					local c_base = {
						"cd $dir &&",
						"gcc $fileName -o",
						"/tmp/$fileNameWithoutExt",
					}
					local c_exec = {
						"&& /tmp/$fileNameWithoutExt &&",
						"rm /tmp/$fileNameWithoutExt",
					}
					require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
				end,

				go = "go run",
				sh = "bash",
				asm = "nasm -f elf64 $fileName && ld $fileNameWithoutExt.o -o $fileNameWithoutExt && ./$fileNameWithoutExt",
				lua = "lua",
			},
		})
	end,
}
