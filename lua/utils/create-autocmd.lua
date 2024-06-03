local M = {}

function M.create_autocmd(events, opts)
	vim.api.nvim_create_autocmd(events, opts)
end

return M
