local profile = require("user.profile")

return {
	-- Rainbow delimiters (depends on treesitter)
	{ "hiphish/rainbow-delimiters.nvim", cond = profile.treesitter_enabled },

	-- Autopairs (always enabled)
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
