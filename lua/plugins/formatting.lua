local profile = require("user.profile")

return {
	{
		"stevearc/conform.nvim",
		cond = profile.formatting_enabled,
		opts = {},
	},
}
