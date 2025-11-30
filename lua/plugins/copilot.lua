local profile = require("user.profile")

return {
	{
		"github/copilot.vim",
		cond = profile.copilot_enabled,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cond = profile.copilot_enabled,
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "nvim-telescope/telescope.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "claude-sonnet-4",
			window = {
				layout = "vertical",
			},
		},
	},
}
