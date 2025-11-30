local profile = require("user.profile")

return {
	-- Setup Rust LSP tools.
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
		cond = profile.rust_enabled,
	},

	-- Fetches crates information.
	{
		"saecki/crates.nvim",
		tag = "stable",
		cond = profile.rust_enabled,
		config = function()
			require("crates").setup()
		end,
	},
}
