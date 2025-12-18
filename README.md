# NeoVim Configuration

A modern NeoVim configuration using **lazy.nvim** for plugin management, with LSP-based development support optimized for Rust and Python.

## Features

- **Feature-based loading** - Conditionally load plugins based on enabled features
- **LSP integration** - Full language server support with Mason for tool management
- **Treesitter** - Advanced syntax highlighting and code folding
- **Fuzzy finding** - Telescope for files, buffers, and symbols
- **AI assistance** - GitHub Copilot or local Ollama via llm.nvim (mutually exclusive)
- **Format on save** - Automatic formatting with conform.nvim
- **Rust tooling** - rustaceanvim with clippy integration

## Quick Start

```bash
# Clone to your config directory
git clone <repo-url> ~/.config/nvim

# Start NeoVim (will auto-install plugins)
nvim
```

## Feature System

The configuration supports opt-in features via the `NEOVIM_FEATURES` environment variable, allowing you to enable exactly the plugins you need.

### Available Features

| Feature | Description |
|---------|-------------|
| `lsp` | Mason, lspconfig, nvim-cmp, Trouble |
| `treesitter` | Syntax highlighting, folding, rainbow-delimiters |
| `rust` | rustaceanvim, crates.nvim |
| `copilot` | GitHub Copilot + CopilotChat |
| `llm` | Local Ollama/Mistral via minuet-ai.nvim |
| `formatting` | conform.nvim auto-formatting |

### Aliases

| Alias | Expands to |
|-------|------------|
| `full` | `lsp treesitter rust copilot formatting` |

### Removal Syntax

Prefix a feature with `-` to remove it:

```bash
# Full setup without Copilot
NEOVIM_FEATURES="full -copilot" nvim
```

### Usage

```bash
# Full development with Copilot (using alias)
NEOVIM_FEATURES="full" nvim

# Full development with local LLM
NEOVIM_FEATURES="lsp treesitter rust llm formatting" nvim

# Development without AI
NEOVIM_FEATURES="lsp treesitter rust formatting" nvim

# Minimal editing (default when unset)
nvim

# Check current features inside NeoVim
:FeatureStatus
```

### Default Features

When `NEOVIM_FEATURES` is unset, these features are enabled: `treesitter formatting`

### Incompatible Features

- `copilot` and `llm` cannot be enabled together (NeoVim will error and exit)

### Shell Aliases (Optional)

Add to your `.bashrc` or `.zshrc`:

```bash
alias nvim-full='NEOVIM_FEATURES="full" nvim'
alias nvim-llm='NEOVIM_FEATURES="lsp treesitter rust llm formatting" nvim'
alias nvim-noai='NEOVIM_FEATURES="lsp treesitter rust formatting" nvim'
alias nvim-min='NEOVIM_FEATURES="" nvim'
```

## Keybindings

### Leader Keys

- **Leader**: `Space`
- **Local Leader**: `;`

### Global Keymaps

| Key | Action | Feature Required |
|-----|--------|------------------|
| `<leader>f` | Find files (Telescope) | - |
| `<leader>b` | Find buffers (Telescope) | - |
| `<leader>l` | Find symbols (Treesitter) | treesitter |
| `<leader>t` | Open file explorer (Oil) | - |
| `<leader>d` | Toggle diagnostics (Trouble) | lsp |
| `<leader>s` | Toggle symbols (Trouble) | lsp |
| `<leader>z` | Toggle zen mode | - |
| `<leader>cc` | Open Copilot Chat | copilot |
| `<leader>ce` | Explain selection (visual) | copilot |
| `<leader>ct` | Generate tests | copilot |
| `<Tab>` | Accept LLM suggestion | llm |
| `<S-Tab>` | Dismiss LLM suggestion | llm |
| `<leader>cfg` | Pull latest config from git | - |

### LSP Keymaps (Buffer-Local)

Available when an LSP server is attached:

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
| `<leader>rn` / `<F2>` | Rename symbol |
| `<leader>ca` / `<C-.>` | Code action |
| `<leader>cf` | Format buffer |
| `<leader>a` | Rust code action (Rust files only) |

## Directory Structure

```
nvim/
├── init.lua                    # Entry point
├── ginit.vim                   # GUI settings (Neovide)
├── lazy-lock.json              # Plugin version lockfile
├── README.md                   # This file
├── CLAUDE.md                   # AI assistant instructions
└── lua/
    ├── user/
    │   ├── options.lua         # Core vim options
    │   └── profile.lua         # Feature-based plugin loading
    ├── config/
    │   ├── lazy.lua            # lazy.nvim bootstrap
    │   ├── mappings.lua        # Global keymaps
    │   ├── autocommands.lua    # Filetype associations
    │   ├── lsp.lua             # LSP configuration
    │   ├── completion.lua      # nvim-cmp setup
    │   ├── formatting.lua      # conform.nvim rules
    │   ├── syntax.lua          # Treesitter config
    │   ├── lualine.lua         # Status line
    │   └── colorscheme.lua     # Theme (tokyonight-storm)
    └── plugins/                # Plugin specs
        ├── lsp.lua             # mason, lspconfig, cmp, trouble
        ├── telescope.lua       # Fuzzy finder
        ├── rust.lua            # rustaceanvim, crates.nvim
        ├── copilot.lua         # GitHub Copilot + CopilotChat
        ├── llm.lua             # Local Ollama via llm.nvim
        ├── formatting.lua      # conform.nvim
        ├── treesitter.lua      # Syntax highlighting
        └── ...                 # Other plugins
```

## Formatters

Format-on-save is enabled by default (500ms timeout).

| Filetype | Formatter(s) |
|----------|--------------|
| lua | stylua |
| python | isort, black |
| rust | rustfmt (edition 2024) |
| javascript/typescript | prettierd, prettier |
| json | jq |
| yaml/html/css | prettierd, prettier |
| sh/bash | shfmt |

## Common Commands

### Plugin Management

| Command | Action |
|---------|--------|
| `:Lazy` | Open lazy.nvim UI |
| `:Lazy update` | Update all plugins |
| `:Lazy sync` | Sync to lockfile |
| `:checkhealth` | Diagnose issues |

### Features & Diagnostics

| Command | Action |
|---------|--------|
| `:FeatureStatus` | Show current features configuration |
| `:Mason` | Open Mason UI for LSP/tool management |
| `:LspInfo` | Show attached LSP servers |
| `:Telescope` | Open Telescope picker |

## Adding New Plugins

1. Create a file in `lua/plugins/` or add to an existing related file
2. Return a lazy.nvim spec:

```lua
-- lua/plugins/example.lua
local profile = require("user.profile")

return {
  "author/plugin-name",
  cond = profile.lsp_enabled,  -- Optional: conditional loading
  opts = { ... },
}
```

3. Restart NeoVim - lazy.nvim auto-discovers new plugin files

### Feature-Aware Plugins

To make a plugin conditional on a feature:

```lua
local profile = require("user.profile")

return {
  {
    "some/plugin",
    cond = profile.lsp_enabled,  -- or treesitter_enabled, rust_enabled, etc.
  },
}
```

## Adding New LSP Servers

1. Add to Mason's `ensure_installed` in `lua/plugins/lsp.lua`
2. Configure in `lua/config/lsp.lua`:

```lua
vim.lsp.config("your_server", {
  on_attach = on_attach,
})
vim.lsp.enable("your_server")
```

## Updating the Config

Pull latest changes:
```bash
cd ~/.config/nvim && git pull
```

Or use `<leader>cfg` from within NeoVim.

After making changes:
```bash
cd ~/.config/nvim
git add -A
git commit -m "Description of changes"
git push
```

## Requirements

- NeoVim 0.9+ (0.10+ recommended)
- Git
- A Nerd Font (for icons)
- For lsp/rust features: Node.js, Python, Rust toolchain
- For llm feature: Ollama running locally (`ollama serve` with `ollama pull mistral`)

## License

MIT
