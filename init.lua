-- This need to go first, as it contains the leader mapping which is used
-- pretty much anywhere.
require("user.options")

-- The plugin manager (Lazy.nvim).
require("user.lazy")

-- Extra configuration for the plugins.
require("user.keymappings")
require("user.colorscheme")
require("user.telescope")
require("user.formatter")
require("user.lualine")
require("user.perforce")
require("user.lsp")
require("user.syntax")
require("user.completion")
require("user.treesitter")
