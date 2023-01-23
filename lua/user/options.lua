vim.opt.autoindent = true -- Automatically indent.
vim.opt.autowrite = true -- Auto-write the file when the buffer changes
vim.opt.cursorline = true -- Highlight the current line
vim.opt.fileformat = "unix" -- Unix line endings
vim.opt.undofile = true -- Persistent undo
vim.opt.completeopt = { "menuone", "noselect", "noinsert" } -- Better completion menu
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.foldlevel = 2
vim.o.scrollback = 100000
vim.o.scrolloff = 10

vim.wo.colorcolumn = "80,120" -- Column rulers
vim.wo.number = true -- Show line numbers
vim.wo.foldmethod = "expr" -- Fold on expressions
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.o.updatetime = 250 -- Don't wait a lot for CursorHold events

vim.g.neo_tree_remove_legacy_commands = true -- Remove legacy commands from neo-tree.

vim.g.terraform_fmt_on_save = true -- Format Terraform files upon save

vim.g.vimtex_view_method = "zathura" -- Set the default viewer for VimTex
vim.g.vimtex_syntax_enabled = 0 -- Fix Treesitter conflicts with VimTex.
vim.g.vimtex_syntax_conceal_disable = 1 -- Same.

-- Enable mouse mode only when not running in tmux
if os.getenv("TMUX") == nil then
	vim.cmd([[set mouse=a]])
end
