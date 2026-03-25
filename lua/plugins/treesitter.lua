local profile = require("user.profile")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cond = profile.treesitter_enabled,
		opts = {
			ensure_installed = { "lua", "rust", "toml", "json", "yaml", "markdown", "markdown_inline", "html" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		},
	},
}
