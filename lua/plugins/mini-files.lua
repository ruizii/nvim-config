return {
	"echasnovski/mini.files",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	keys = {
		{
			"<C-b>",
			function()
				MiniFiles.open()
			end,
			{ remap = true, silent = true },
		},
	},
	version = false,
	config = true,
}
