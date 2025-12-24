return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		filesystem = {
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			follow_current_file = {
				enabled = false,
			},
		},
		window = {
			width = 30,
			mappings = {
				["<Esc>"] = "close_window",
			},
		},
		default_component_configs = {
			git_status = {
				symbols = {
					added = "+",
					modified = "~",
					deleted = "x",
					renamed = "r",
					untracked = "?",
					ignored = "i",
					unstaged = "u",
					staged = "s",
					conflict = "!",
				},
			},
		},
	},
}
