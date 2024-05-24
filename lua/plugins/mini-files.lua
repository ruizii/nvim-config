return {
	"echasnovski/mini.files",
	version = false,
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
	config = true,
}
