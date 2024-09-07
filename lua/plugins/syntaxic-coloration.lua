return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "p00f/nvim-ts-rainbow" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
