local M = {}
local utils = require("utils.helpers")
local create_autocmd = utils.create_autocmd
local opts_extend = utils.opts_extend

function M.highlight_on_yank(opts)
	opts = opts_extend({ timeout = 150 }, opts)
	create_autocmd("TextYankPost", {
		desc = "Highlight text on yank",
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "Search",
				timeout = opts.timeout,
				on_visual = true,
			})
		end,
	})
end

return M
