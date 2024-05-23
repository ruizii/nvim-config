return {
	"echasnovski/mini.files",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	keys = {
		{
			"<C-b>",
			function()
				---@diagnostic disable-next-line
				MiniFiles.open()
			end,
			{ remap = true, silent = true },
		},
	},
	version = false,
	opts = {
		mappings = {
			go_in_plus = "<CR>",
		},
	},
}
