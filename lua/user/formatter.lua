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
	},
})

vim.cmd([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWriteLock
  augroup END
]])

-- Format Rust using LSP.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.rs" },
	callback = function()
		vim.lsp.buf.formatting_sync(nil, 200)
	end,
})
