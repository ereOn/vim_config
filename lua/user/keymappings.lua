-- Fuzzy search
vim.keymap.set("n", "<leader>f", require("telescope.builtin").fd, {})
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, {})
vim.keymap.set("n", "<leader>l", require("telescope.builtin").treesitter, {})

-- Neotree
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", {})

-- Trouble
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", {})
vim.keymap.set("n", "<leader>s", "<cmd>Trouble symbols toggle focus=false<cr>", bufopts)

-- Zen mode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", bufopts)

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-><C-n>", {})

-- Update the configuration
vim.keymap.set("n", "<leader>cfg", "<cmd>!cd $MYVIMRC:h && git pull<cr>", {})
