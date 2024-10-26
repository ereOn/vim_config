return {
	-- Terraform
	"hashivim/vim-terraform",

	-- YAML
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" }, -- optional
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
		},
	},

	--- VimTex
	"lervag/vimtex",

	--- Plist
	"darfink/vim-plist",

	--- Toml
	"cespare/vim-toml",

	-- Markdown
	"godlygeek/tabular",
	"preservim/vim-markdown",

	-- Justfile
	"IndianBoy42/tree-sitter-just",
}
