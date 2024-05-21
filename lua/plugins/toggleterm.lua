return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = { "<C-t>" },
	cmd = {
		"TermExec",
		"ToggleTerm",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
		"ToggleTermSetName",
	},
	opts = {
		open_mapping = [[<C-t>]],
		hide_numbers = true,
		autochdir = true,
		insert_mappings = true,
		shade_terminals = false,
		close_on_exit = false,
	},
}
