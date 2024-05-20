local global = {
	cache_dir = string.format("%s/.cache/nvim", os.getenv("HOME")),
	modules_dir = string.format("%s/modules", vim.fn.stdpath("config")),
	data_dir = string.format("%s/site", vim.fn.stdpath("data")),
}

return global
