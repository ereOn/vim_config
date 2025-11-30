local profile = require("user.profile")

return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", cond = profile.treesitter_enabled },
}
