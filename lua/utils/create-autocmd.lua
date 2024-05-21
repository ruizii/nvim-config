local M = {}

local group = vim.api.nvim_create_augroup("AsdfAutocmdGroup", { clear = true })

function M.create_autocmd(events, opts)
	opts = vim.tbl_extend("force", opts, { group = group })
	vim.api.nvim_create_autocmd(events, opts)
end

return M
