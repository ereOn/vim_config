return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
		float = {
			padding = 2,
			max_width = 100,
			max_height = 30,
		},
		keymaps = {
			["<Esc>"] = "actions.close",
		},
	},
}
