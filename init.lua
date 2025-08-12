-- This need to go first, as it contains the leader mapping which is used
-- pretty much anywhere.
require("user.options")

-- The plugin manager (Lazy.nvim).
require("config.lazy")

-- The key mappings.
require("config.mappings")

-- The status line.
require("config.lualine")

-- The colorscheme.
require("config.colorscheme")

-- The autocommands.
require("config.autocommands")

-- Completion.
require("config.completion")

-- Syntax highlighting.
require("config.syntax")

-- Formatting.
require("config.formatting")

-- Perforce integration.
require("config.perforce")

-- LSP.
require("config.lsp")
