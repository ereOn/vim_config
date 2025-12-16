-- Profile-based plugin loading configuration
-- Set NEOVIM_PROFILE env var to: full, minimal, no-rust, no-ai, or llm
-- Default: minimal (when env var is unset)

local M = {}

local profiles = {
	full = { lsp = true, treesitter = true, rust = true, copilot = true, llm = false, formatting = true },
	minimal = { lsp = false, treesitter = false, rust = false, copilot = false, llm = false, formatting = false },
	["no-rust"] = { lsp = true, treesitter = true, rust = false, copilot = true, llm = false, formatting = true },
	["no-ai"] = { lsp = true, treesitter = true, rust = true, copilot = false, llm = false, formatting = true },
	llm = { lsp = true, treesitter = true, rust = true, copilot = false, llm = true, formatting = true },
}

function M.get_profile()
	local profile = os.getenv("NEOVIM_PROFILE")
	return (profile and profiles[profile]) and profile or "minimal"
end

function M.has(category)
	local config = profiles[M.get_profile()]
	if config and config[category] ~= nil then
		return config[category]
	end
	return true -- Default to enabled for unknown categories
end

-- Convenience functions for lazy.nvim cond
function M.lsp_enabled()
	return M.has("lsp")
end

function M.treesitter_enabled()
	return M.has("treesitter")
end

function M.rust_enabled()
	return M.has("rust")
end

function M.copilot_enabled()
	return M.has("copilot")
end

function M.formatting_enabled()
	return M.has("formatting")
end

function M.llm_enabled()
	return M.has("llm")
end

-- Debug command
vim.api.nvim_create_user_command("ProfileStatus", function()
	local profile = M.get_profile()
	print("NeoVim Profile: " .. profile)
	print("Categories:")
	for cat, enabled in pairs(profiles[profile]) do
		print("  " .. cat .. ": " .. tostring(enabled))
	end
end, { desc = "Show current NeoVim profile status" })

return M
