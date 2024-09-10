return {

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
		},
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
}
