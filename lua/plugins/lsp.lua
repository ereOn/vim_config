return {
	-- Manage external tooling like LSP servers, linters, and formatters.
	{
		"williamboman/mason.nvim",
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
	"neovim/nvim-lspconfig",

	-- Auto highlight other uses of the word under the cursor.
	"RRethy/vim-illuminate",

	-- Completion framework
	"hrsh7th/nvim-cmp",

	-- LSP completion source
	"hrsh7th/cmp-nvim-lsp",

	-- Other useful completion sources.
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/vim-vsnip",

	-- Trouble.
	{
		"folke/trouble.nvim",
		version = "v3.6.0",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	-- TODO comments.
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
}
