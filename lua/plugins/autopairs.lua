return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	lazy = true,
	config = true,
	opts = {
		enable_bracket_in_quote = false,
		check_ts = true,
	},
}
