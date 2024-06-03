local config = {
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"Pmenu",
		"WinBar",
	},
}

local function clear_group()
	local groups = config.groups
	for _, v in ipairs(groups) do
		---@diagnostic disable-next-line
		local _, prev_attrs = pcall(vim.api.nvim_get_hl_by_name, v, true)
		local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
		attrs[true] = nil
		vim.api.nvim_set_hl(0, v, attrs)
	end
end

clear_group()
