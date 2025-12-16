local profile = require("user.profile")

return {
	{
		"milanglacier/minuet-ai.nvim",
		cond = profile.llm_enabled,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 4096,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						end_point = "http://localhost:11434/v1/completions",
						model = "qwen2.5-coder:1.5b",
						name = "Ollama",
						stream = true,
						optional = {
							max_tokens = 128,
							top_p = 0.95,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						accept = "<Tab>",
						dismiss = "<S-Tab>",
					},
				},
			})
		end,
	},
}
