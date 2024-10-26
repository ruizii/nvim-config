return {
	"otavioschwanck/arrow.nvim",
	event = "User FilePost",
	dependencies = {
		{ "echasnovski/mini.icons" },
	},
	opts = {
		show_icons = true,
		leader_key = ";", -- Recommended to be a single key
		buffer_leader_key = "m", -- Per Buffer Mappings
	},
}
