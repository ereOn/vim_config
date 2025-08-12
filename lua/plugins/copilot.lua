return {
	{
		"github/copilot.vim",
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
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
