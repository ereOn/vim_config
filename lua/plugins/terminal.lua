return {
	{
		"s1n7ax/nvim-terminal",
		config = function()
			vim.o.hidden = true

			require("nvim-terminal").setup({
				--disable_default_keymaps = true,
				toggle_keymap = "<C-`>",
			})
		end,
	},
}
