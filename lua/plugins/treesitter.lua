return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local ts = require("nvim-treesitter")

		-- Helper to start highlighting and indentation
		local function start(buf, lang)
			if not vim.api.nvim_buf_is_valid(buf) then
				return false
			end

			local ok = pcall(vim.treesitter.start, buf, lang)
			-- Python's built-in indent file handles more cases than the treesitter one
			if ok and lang ~= "python" then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
			return ok
		end

		-- Install core parsers after lazy.nvim finishes loading all plugins
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			once = true,
			callback = function()
				ts.install({
					"bash",
					"comment",
					"css",
					"diff",
					"git_config",
					"git_rebase",
					"gitcommit",
					"gitignore",
					"html",
					"javascript",
					"json",
					"latex",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"python",
					"c",
					"cpp",
					"rust",
					"nasm",
					"php",
					"go",
					"sql",
					"gomod",
					"gosum",
					"gotmpl",
					"asm",
					"query",
					"regex",
					"scss",
					"yaml",
					"toml",
					"tsx",
					"typescript",
					"typst",
					"vim",
					"vimdoc",
					"xml",
				}, {
					max_jobs = 8,
				})
			end,
		})

		local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

		-- Languages nvim-treesitter has parsers for, computed on first use
		local available

		local ignore_filetypes = {
			"checkhealth",
			"lazy",
			"mason",
			"snacks_picker_input",
			"snacks_layout_box",
			"snacks_picker_list",
			"snacks_notif",
			"snacks_win",
			"snacks_input",
			"bigfile",
			"man",
			"noice",
			"neo-tree",
			"blink-cmp-menu",
			"TelescopePrompt",
			"TelescopeResults",
			"conform-info",
			"toggleterm",
			"text",
			"blink-cmp-documentation",
			"conf",
		}

		-- Auto-install parsers and enable highlighting on FileType
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			desc = "Enable treesitter highlighting and indentation (non-blocking)",
			callback = function(event)
				if vim.tbl_contains(ignore_filetypes, event.match) then
					return
				end

				local lang = vim.treesitter.language.get_lang(event.match) or event.match
				local buf = event.buf

				available = available or ts.get_available()
				if not vim.list_contains(available, lang) then
					return
				end

				local ok, installed = pcall(vim.treesitter.language.add, lang)
				if ok and installed then
					start(buf, lang)
					return
				end

				-- Parser missing: install it, then start once it's ready
				ts.install({ lang }):await(function(err)
					if not err then
						vim.schedule(function()
							start(buf, lang)
						end)
					end
				end)
			end,
		})
	end,
}
