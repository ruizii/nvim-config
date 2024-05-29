return {
	"David-Kunz/gen.nvim",
	cmd = "Gen",
	keys = {
		{ "<leader>]", "<cmd>Gen<CR>", mode = { "n" }, desc = "AI" },
	},
	opts = {
		model = "codeqwen:7b-chat-v1.5-q5_1",
		display_mode = "split",
		show_prompt = true,
	},
	config = function(_, opts)
		require("gen").setup(opts)
	end,
}
