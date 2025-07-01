return {
	"mhartington/formatter.nvim",
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					require("none-ls.diagnostics.ruff").with({
						extra_args = {
							"--no-isort",
						},
					}),
				},
			})
		end,
	},
}
