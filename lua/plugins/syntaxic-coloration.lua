return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"hiphish/rainbow-delimiters.nvim",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
