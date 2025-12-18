-- Feature-based plugin loading configuration
-- Set NEOVIM_FEATURES env var to space-separated feature list
-- Example: NEOVIM_FEATURES="lsp treesitter rust copilot formatting"
-- Available features: lsp, treesitter, rust, copilot, llm, formatting
-- Aliases: full (expands to: lsp treesitter rust copilot formatting)
-- Prefix with - to remove: NEOVIM_FEATURES="full -copilot"
-- Default (when unset): treesitter formatting

local M = {}

-- Define available features
local available_features = {
	"lsp",
	"treesitter",
	"rust",
	"copilot",
	"llm",
	"formatting",
}

-- Default features when env var is unset
local default_features = { "treesitter", "formatting" }

-- Incompatible feature pairs (each pair is mutually exclusive)
local incompatible_pairs = {
	{ "copilot", "llm" },
}

-- Feature aliases (shorthand for common combinations)
local feature_aliases = {
	full = { "lsp", "treesitter", "rust", "copilot", "formatting" },
}

-- Parse the features from environment variable
local function parse_features()
	local env_value = os.getenv("NEOVIM_FEATURES")

	-- If unset, return defaults
	if not env_value or env_value == "" then
		return default_features
	end

	-- Split by whitespace and process additions first, then removals
	local additions = {}
	local removals = {}

	for token in env_value:gmatch("%S+") do
		if token:sub(1, 1) == "-" then
			-- Removal token (e.g., "-copilot")
			local feature_to_remove = token:sub(2)
			table.insert(removals, feature_to_remove)
		else
			-- Addition token (feature or alias)
			local alias_expansion = feature_aliases[token]
			if alias_expansion then
				for _, feature in ipairs(alias_expansion) do
					table.insert(additions, feature)
				end
			else
				table.insert(additions, token)
			end
		end
	end

	-- Build final feature set: additions minus removals
	local features = {}
	local seen = {}
	local removal_set = {}
	for _, r in ipairs(removals) do
		removal_set[r] = true
	end

	for _, feature in ipairs(additions) do
		if not seen[feature] and not removal_set[feature] then
			seen[feature] = true
			table.insert(features, feature)
		end
	end

	return features
end

-- Validate features and check for incompatibilities
local function validate_features(features)
	-- Create a set for O(1) lookup
	local feature_set = {}
	for _, f in ipairs(features) do
		feature_set[f] = true
	end

	-- Check for unknown features (warning only, don't fail)
	local valid_set = {}
	for _, f in ipairs(available_features) do
		valid_set[f] = true
	end
	for _, f in ipairs(features) do
		if not valid_set[f] then
			vim.api.nvim_err_writeln("Warning: Unknown feature '" .. f .. "' in NEOVIM_FEATURES")
		end
	end

	-- Check for incompatible features (fatal error)
	for _, pair in ipairs(incompatible_pairs) do
		if feature_set[pair[1]] and feature_set[pair[2]] then
			vim.api.nvim_err_writeln(
				"Error: Incompatible features specified: '"
					.. pair[1]
					.. "' and '"
					.. pair[2]
					.. "' cannot be enabled together"
			)
			vim.api.nvim_err_writeln("Please modify NEOVIM_FEATURES and restart NeoVim")
			vim.cmd("cquit 1")
		end
	end

	return feature_set
end

-- Parse and validate on module load
local enabled_features = validate_features(parse_features())

-- Check if a feature is enabled
function M.has(feature)
	return enabled_features[feature] == true
end

-- Get list of enabled features (for debugging)
function M.get_enabled_features()
	local result = {}
	for feature, _ in pairs(enabled_features) do
		table.insert(result, feature)
	end
	table.sort(result)
	return result
end

-- Convenience functions for lazy.nvim cond (maintain existing API)
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
vim.api.nvim_create_user_command("FeatureStatus", function()
	local env_value = os.getenv("NEOVIM_FEATURES") or "(unset - using defaults)"
	print("NEOVIM_FEATURES: " .. env_value)
	print("")
	print("Enabled features:")
	for _, feature in ipairs(available_features) do
		local status = M.has(feature) and "enabled" or "disabled"
		print("  " .. feature .. ": " .. status)
	end
	print("")
	print("Available aliases:")
	for alias, expansion in pairs(feature_aliases) do
		print("  " .. alias .. " -> " .. table.concat(expansion, " "))
	end
end, { desc = "Show enabled NeoVim features" })

return M
