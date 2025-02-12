return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
	build = ":MasonUpdate",
	opts = {
		ui = {
			border = "single",
		},
	},
}
