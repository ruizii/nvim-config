local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.copyindent = true
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = false -- Disable highlighting of the current line
opt.cmdheight = 0
opt.ignorecase = true -- Ignore case
opt.incsearch = true
opt.infercase = true
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.mouse = "a" -- Enable mouse mode
opt.mousemoveevent = true
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.shiftround = true -- Round indent
opt.shiftwidth = 4
opt.tabstop = 4 -- Number of spaces tabs count for
opt.softtabstop = 4
opt.expandtab = true
opt.shortmess:append("WIcCq") -- Sh
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.breakindent = true
opt.linebreak = true
opt.undolevels = 2000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wrap = false -- Disable line wrap
opt.scrolloff = 8
opt.smoothscroll = true
opt.pumheight = 10

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.cmd("let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']")

-- WSL --

if os.getenv("WSL_DISTRO_NAME") then
	vim.cmd([[
        let s:win32yank = resolve('/mnt/c/Program Files/Neovim/bin/win32yank.exe')
        let g:clipboard = #{
                    \   name: 'win32yank',
                    \   copy: {
                    \     '+': [s:win32yank, '-i', '--crlf'],
                    \     '*': [s:win32yank, '-i', '--crlf'],
                    \   },
                    \   paste: {
                    \     '+': [s:win32yank, '-o', '--lf'],
                    \     '*': [s:win32yank, '-o', '--lf'],
                    \   },
                    \ }
        unlet s:win32yank
    ]])
end
