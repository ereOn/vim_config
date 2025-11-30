local profile = require("user.profile")

return {
	-- Terraform
	"hashivim/vim-terraform",

	-- YAML (depends on treesitter)
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		cond = profile.treesitter_enabled,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
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

	-- Justfile (depends on treesitter)
	{ "IndianBoy42/tree-sitter-just", cond = profile.treesitter_enabled },
}
