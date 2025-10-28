return {

	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		opts = {
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
		},
	},
}
