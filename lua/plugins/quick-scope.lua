return {
	"unblevable/quick-scope",
	event = { "User FilePost" },
	config = function()
		vim.cmd("let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']")
	end,
}
