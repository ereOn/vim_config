# NeoVim Configuration - Claude Instructions

This is a modern NeoVim configuration using **lazy.nvim** for plugin management, with LSP-based development support optimized for Rust and Python.

## Directory Structure

```
nvim/
├── init.lua                    # Entry point - loads all config modules
├── ginit.vim                   # GUI settings (Neovide)
├── lazy-lock.json              # Plugin version lockfile
└── lua/
    ├── user/
    │   └── options.lua         # Core vim options (leader keys, UI settings)
    ├── config/
    │   ├── lazy.lua            # lazy.nvim bootstrap
    │   ├── mappings.lua        # Global keymaps
    │   ├── autocommands.lua    # Filetype associations, auto-behaviors
    │   ├── lsp.lua             # LSP on_attach, keymaps, diagnostics config
    │   ├── completion.lua      # nvim-cmp setup
    │   ├── formatting.lua      # conform.nvim formatter rules
    │   ├── lualine.lua         # Status line
    │   ├── colorscheme.lua     # Theme (tokyonight-storm)
    │   ├── syntax.lua          # Treesitter config
    │   └── perforce.lua        # Perforce VCS settings
    └── plugins/                # Plugin specs (one file per plugin/group)
        ├── lsp.lua             # mason, lspconfig, cmp, trouble
        ├── telescope.lua       # Fuzzy finder
        ├── neo-tree.lua        # File explorer
        ├── rust.lua            # rustaceanvim, crates.nvim
        ├── copilot.lua         # GitHub Copilot + CopilotChat
        ├── formatting.lua      # conform.nvim plugin spec
        └── ...                 # Other plugin files
```

## Plugin Conventions

Plugins are defined in `lua/plugins/*.lua`. Each file returns a table of lazy.nvim specs.

### Adding a New Plugin

1. Create a new file in `lua/plugins/` (or add to existing related file)
2. Return a lazy.nvim spec table:

```lua
-- lua/plugins/example.lua
return {
  "author/plugin-name",
  version = "*",           -- Optional: pin to stable releases
  dependencies = { ... },  -- Optional: required plugins
  opts = { ... },          -- Plugin options (passed to setup())
  config = function()      -- Or use config for custom setup
    require("plugin").setup({ ... })
  end,
  keys = { ... },          -- Lazy-load on keymaps
  ft = { "lua", "rust" },  -- Lazy-load on filetypes
  event = "VeryLazy",      -- Lazy-load timing
}
```

3. Restart NeoVim - lazy.nvim auto-discovers new plugin files

### Plugin Configuration Pattern

- **Simple config**: Use `opts = {}` - lazy.nvim calls `setup(opts)` automatically
- **Complex config**: Use `config = function() ... end` for custom logic
- **Separate config file**: Define plugin in `lua/plugins/`, configure in `lua/config/`

## LSP & Language Support

### Architecture

- **Mason** (`lua/plugins/lsp.lua`): Installs external tools (LSP servers, formatters)
- **lspconfig** (`lua/plugins/lsp.lua`): Plugin spec with mason-lspconfig bridge
- **LSP config** (`lua/config/lsp.lua`): on_attach callbacks, keymaps, diagnostic settings

### Adding a New LSP Server

1. Add to Mason's ensure_installed in `lua/plugins/lsp.lua`:

```lua
-- In the mason-lspconfig setup
ensure_installed = {
  "gopls",
  "pyright",
  "your_new_server",  -- Add here
}
```

2. Configure the server in `lua/config/lsp.lua`:

```lua
-- At the end of the file, add:
vim.lsp.config("your_new_server", {
  on_attach = on_attach_callback,
  -- Add server-specific settings here
})
vim.lsp.enable("your_new_server")
```

3. For complex language setups (like Rust), create a dedicated plugin file in `lua/plugins/`

### LSP Keymaps (buffer-local)

Defined in `lua/config/lsp.lua` within `on_attach_callback`:

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | References (Telescope) |
| `gR` | References (Trouble) |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>D` | Type definition |
| `<leader>rn` / `<F2>` | Rename |
| `<leader>ca` / `<C-.>` | Code action |
| `<leader>cf` | Format buffer |

## Formatting

Formatting uses **conform.nvim** configured in `lua/config/formatting.lua`.

### Adding a New Formatter

1. Install the formatter via Mason (add to `ensure_installed` in `lua/plugins/lsp.lua`) or system package manager

2. Add formatter mapping in `lua/config/formatting.lua`:

```lua
formatters_by_ft = {
  -- existing formatters...
  your_filetype = { "your_formatter" },
  -- For fallback chain: { "preferred", "fallback" }
  -- For sequential: { "first", "second" } with stop_after_first = false
}
```

3. Format-on-save is enabled by default (500ms timeout)

### Current Formatters

| Filetype | Formatter(s) |
|----------|--------------|
| lua | stylua |
| python | isort, black |
| rust | rustfmt (edition 2024) |
| javascript/typescript | prettierd, prettier |
| json | jq |
| yaml/html/css | prettierd, prettier |
| sh/bash | shfmt |

## Keybinding Patterns

### Leader Keys

- **Leader**: Space (` `)
- **Local Leader**: Semicolon (`;`)

Set in `lua/user/options.lua` - must load before plugins.

### Global Keymaps (`lua/config/mappings.lua`)

| Key | Action |
|-----|--------|
| `<leader>f` | Find files (Telescope) |
| `<leader>b` | Find buffers (Telescope) |
| `<leader>l` | Find symbols (Treesitter) |
| `<leader>t` | Toggle file tree (neo-tree) |
| `<leader>d` | Toggle diagnostics (Trouble) |
| `<leader>s` | Toggle symbols (Trouble) |
| `<leader>z` | Toggle zen mode |
| `<leader>cc` | Copilot Chat |

### Adding New Keybindings

**Global mappings**: Add to `lua/config/mappings.lua`:

```lua
vim.keymap.set("n", "<leader>x", function()
  -- action
end, { desc = "Description" })
```

**Plugin-specific mappings**: Add to the plugin's `keys` table in its spec file:

```lua
keys = {
  { "<leader>x", "<cmd>PluginCommand<cr>", desc = "Description" },
}
```

**LSP mappings**: Add to `on_attach_callback` in `lua/config/lsp.lua`

## Common Maintenance Tasks

### Add a Filetype Association

Edit `lua/config/autocommands.lua`:

```lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.your_ext" },
  callback = function()
    vim.bo.filetype = "your_filetype"
  end,
})
```

### Update Plugins

Plugins auto-update on NeoVim startup. Manual update:
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync to lockfile

### Check Plugin Status

- `:Lazy` - Open lazy.nvim UI
- `:checkhealth` - Diagnose issues

### Modify Load Order

The load sequence in `init.lua` is intentional:
1. `user.options` - Leader keys must be set first
2. `config.lazy` - Bootstrap plugin manager
3. Other configs in dependency order

## Important Conventions

1. **Format-on-save** is default for all configured filetypes
2. **Diagnostics** display as virtual lines (no gutter signs)
3. **Plugins auto-update** silently on startup
4. **Telescope** is the universal picker (files, buffers, LSP references)
5. **Treesitter** handles syntax highlighting and folding
6. **Mason** manages external tool installation
7. **Rust uses rustaceanvim** (not rust-tools) with clippy on save
8. **Copilot Chat** uses Claude Sonnet 4 model

## GitHub Backup

Config is backed up to GitHub. After changes:

```bash
cd ~/.config/nvim
git add -A
git commit -m "Description of changes"
git push
```

Or use `<leader>cfg` to pull latest changes from the repo.
