return {
	-- Setup Rust LSP tools.
	"simrat39/rust-tools.nvim",

	-- Fetches crates information.
	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},
}
