local profile = require("user.profile")

return {
	-- Manage external tooling like LSP servers, linters, and formatters.
	{
		"williamboman/mason.nvim",
		cond = profile.lsp_enabled,
		config = function()
			require("mason").setup({
				ensure_installed = {
					"prettier",
				},
			})
		end,
	},

	-- Bridge mason with the lspconfig plugin.
	{
		"williamboman/mason-lspconfig.nvim",
		cond = profile.lsp_enabled,
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"pyright",
					"ruff",
				},
			})
		end,
	},

	-- LSP configurations.
	{ "neovim/nvim-lspconfig", cond = profile.lsp_enabled },

	-- Auto highlight other uses of the word under the cursor.
	{ "RRethy/vim-illuminate", cond = profile.lsp_enabled },

	-- Completion framework
	{ "hrsh7th/nvim-cmp", cond = profile.lsp_enabled },

	-- LSP completion source
	{ "hrsh7th/cmp-nvim-lsp", cond = profile.lsp_enabled },

	-- Other useful completion sources.
	{ "hrsh7th/cmp-nvim-lua", cond = profile.lsp_enabled },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", cond = profile.lsp_enabled },
	{ "hrsh7th/cmp-vsnip", cond = profile.lsp_enabled },
	{ "hrsh7th/cmp-path", cond = profile.lsp_enabled },
	{ "hrsh7th/cmp-buffer", cond = profile.lsp_enabled },
	{ "hrsh7th/vim-vsnip", cond = profile.lsp_enabled },

	-- Trouble.
	{
		"folke/trouble.nvim",
		version = "v3.6.0",
		cond = profile.lsp_enabled,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	-- TODO comments (always enabled - uses regex, not LSP).
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
}
