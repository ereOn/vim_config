# NeoVim Configuration

A modern NeoVim configuration using **lazy.nvim** for plugin management, with LSP-based development support optimized for Rust and Python.

## Features

- **Profile-based loading** - Conditionally load plugins based on machine capabilities
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

## Profile System

The configuration supports different profiles via the `NEOVIM_PROFILE` environment variable, allowing the same config to work on machines with varying capabilities.

### Available Profiles

| Profile | Description |
|---------|-------------|
| `full` | All plugins enabled with GitHub Copilot (main dev machine) |
| `minimal` | Core editing only, no heavy tooling (default) |
| `no-rust` | Full LSP support but skip Rust-specific plugins |
| `no-ai` | Full development support without any AI assistance |
| `llm` | Local Ollama/Mistral instead of Copilot |

### Usage

```bash
# Full profile (all plugins with Copilot)
NEOVIM_PROFILE=full nvim

# Local LLM profile (Ollama/Mistral instead of Copilot)
NEOVIM_PROFILE=llm nvim

# No AI profile (full tooling, no AI)
NEOVIM_PROFILE=no-ai nvim

# No rust profile (LSP but no Rust tooling)
NEOVIM_PROFILE=no-rust nvim

# Minimal profile (default when unset)
nvim

# Check current profile inside NeoVim
:ProfileStatus
```

### Shell Aliases (Optional)

Add to your `.bashrc` or `.zshrc`:

```bash
alias nvim-full='NEOVIM_PROFILE=full nvim'
alias nvim-min='NEOVIM_PROFILE=minimal nvim'
alias nvim-norust='NEOVIM_PROFILE=no-rust nvim'
alias nvim-llm='NEOVIM_PROFILE=llm nvim'
alias nvim-noai='NEOVIM_PROFILE=no-ai nvim'
```

### What Each Profile Enables

| Category | full | minimal | no-rust | no-ai | llm |
|----------|------|---------|---------|-------|-----|
| LSP/Completion | Yes | No | Yes | Yes | Yes |
| Treesitter | Yes | No | Yes | Yes | Yes |
| Rust (rustaceanvim) | Yes | No | No | Yes | Yes |
| Copilot | Yes | No | Yes | No | No |
| llm.nvim (Ollama) | No | No | No | No | Yes |
| Formatting | Yes | No | Yes | Yes | Yes |

## Keybindings

### Leader Keys

- **Leader**: `Space`
- **Local Leader**: `;`

### Global Keymaps

| Key | Action | Profile Required |
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
    │   └── profile.lua         # Profile-based plugin loading
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

### Profile & Diagnostics

| Command | Action |
|---------|--------|
| `:ProfileStatus` | Show current profile and enabled categories |
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

### Profile-Aware Plugins

To make a plugin conditional on a profile category:

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
- For full profile: Node.js, Python, Rust toolchain
- For llm profile: Ollama running locally (`ollama serve` with `ollama pull mistral`)

## License

MIT
