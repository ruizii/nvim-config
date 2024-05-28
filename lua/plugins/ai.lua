return {
	"David-Kunz/gen.nvim",
	cmd = "Gen",
	keys = {
		{ "<leader>]", "<cmd>Gen<CR>", desc = "AI" },
	},
	opts = {
		model = "codeqwen:7b-chat-v1.5-q5_1",
		display_mode = "split",
	},
}
