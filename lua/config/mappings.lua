local profile = require("user.profile")

-- Fuzzy search (always available)
vim.keymap.set("n", "<leader>f", require("telescope.builtin").fd, { desc = "Fuzzy search files" })
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, { desc = "Fuzzy search buffers" })

-- Treesitter symbol search (only with treesitter)
if profile.treesitter_enabled() then
	vim.keymap.set("n", "<leader>l", require("telescope.builtin").treesitter, { desc = "Fuzzy search symbols" })
end

-- Neo-tree file explorer (always available)
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- Trouble (only with LSP)
if profile.lsp_enabled() then
	vim.keymap.set(
		"n",
		"<leader>d",
		"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
		{ desc = "Toggle Trouble diagnostics" }
	)
	vim.keymap.set(
		"n",
		"<leader>s",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		{ desc = "Toggle Trouble symbols" }
	)
end

-- Zen mode (always available)
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen mode" })

-- Update the configuration (always available)
vim.keymap.set("n", "<leader>cfg", "<cmd>!cd $MYVIMRC:h && git pull<cr>", { desc = "Update configuration" })

-- Copilot Chat (only with copilot)
if profile.copilot_enabled() then
	vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Open Copilot Chat" })
	vim.keymap.set("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Explain the selection" })
	vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests #buffer<cr>", { desc = "Write tests for the file" })
	vim.keymap.set("v", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "Write tests for the selection" })

	-- This unmaps the <Tab> key in Copilot Chat so that completion works.
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			if vim.bo.filetype == "copilot-chat" then
				vim.schedule(function()
					local mappings = vim.api.nvim_buf_get_keymap(0, "i")
					for _, map in ipairs(mappings) do
						if map.lhs == "<Tab>" then
							vim.cmd("iunmap <buffer> <Tab>")
							break
						end
					end
				end)
			end
		end,
	})
end

-- Telescope mappings.
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
				["<c-d>"] = require("telescope.actions").delete_buffer,
			},
			n = {
				["<c-d>"] = require("telescope.actions").delete_buffer,
			},
		},
	},
})
