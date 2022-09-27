-- Fuzzy search
vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<C-b>", require("telescope.builtin").buffers, {})
vim.keymap.set("n", "<C-l>", require("telescope.builtin").treesitter, {})

-- Neotree
vim.keymap.set("n", "<C-left>", "<cmd>Neotree toggle<cr>", {})

-- Trouble
vim.keymap.set("n", "<C-down>", "<cmd>Trouble<cr>", {})
vim.keymap.set("n", "<C-up>", "<cmd>TroubleClose<cr>", {})

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-><C-n>", {})
