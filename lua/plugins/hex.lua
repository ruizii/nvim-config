return {
	"RaafatTurki/hex.nvim",
	lazy = "-b" ~= vim.v.argv[3],
	-- Mapping in mappings.lua
	cmd = "HexToggle",
	config = function()
		require("hex").setup()
	end,
}
