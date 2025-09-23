require("conform").setup({
	formatters_by_ft = {
		-- Bash.
		sh = { "shfmt" },
		bash = { "shfmt" },
		-- Lua.
		lua = { "stylua" },
		-- Python.
		python = { "isort", "black" },
		-- Rust.
		rust = { "rustfmt" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		-- JSON uses jq.
		json = { "jq" },
		-- YAML, and HTML will use Prettier by default
		yaml = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		scss = { "prettierd", "prettier" },
		-- Make sure to install prettier-plugin-jinja-template
		-- npm install --save-dev prettier prettier-plugin-jinja-template
		--
		-- And to add a .prettierrc file with the following content:
		--
		-- {
		--   "plugins": [
		--     "prettier-plugin-jinja-template"
		--   ],
		--   "overrides": [
		--     {
		--       "files": "*.html.jinja",
		--       "options": {
		--         "parser": "jinja-template"
		--       }
		--     }
		--   ]
		-- }
		htmldjango = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- YAML specific settings.
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

-- Justfiles.
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
