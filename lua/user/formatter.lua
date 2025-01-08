-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		json = { require("formatter.filetypes.json").jq },
		css = { require("formatter.filetypes.css").prettier },
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.djlint,
		null_ls.builtins.formatting.djlint,
	},
})

vim.cmd([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWriteLock
  augroup END
]])

-- Format Rust, HTML Django, CSS using LSP.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.rs", "*.html.jinja", "*.html", "*.css" },
	callback = function()
		vim.lsp.buf.format(nil, 200)
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "yaml" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		vim.opt_local.indentkeys:remove("0#") -- For some reason it gets overriden.
	end,
})

events = { "BufRead", "BufNewFile" }

for _, event in ipairs(events) do
	vim.api.nvim_create_autocmd({ event }, {
		pattern = { "justfile" },
		callback = function()
			vim.opt_local.filetype = "just"
		end,
	})

	vim.api.nvim_create_autocmd({ event }, {
		pattern = { "*.html.jinja", "*.html.jinja2" },
		callback = function()
			vim.opt_local.filetype = "htmldjango"
		end,
	})
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "justfile" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		vim.opt_local.indentkeys:remove("0#") -- For some reason it gets overriden.
	end,
})
