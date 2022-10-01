-- Fuzzy search
vim.keymap.set("n", "<leader>p", require("telescope.builtin").fd, {})
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, {})
vim.keymap.set("n", "<leader>l", require("telescope.builtin").treesitter, {})

-- Neotree
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", {})

-- Trouble
vim.keymap.set("n", "<C-down>", "<cmd>Trouble<cr>", {})
vim.keymap.set("n", "<C-up>", "<cmd>TroubleClose<cr>", {})

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-><C-n>", {})

-- Update the configuration
vim.keymap.set("n", "<leader>cfg", "<cmd>!cd $MYVIMRC:h && git pull<cr>", {})
