-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- Geral
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- fzf (também definidos em plugins/fzf.lua via lazy keys; duplicação não faz mal)
map("n", "<leader>ff", "<cmd>Files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Rg<CR>", { desc = "Ripgrep" })
map("n", "<leader>fb", "<cmd>Buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>History<CR>", { desc = "History" })

-- Fugitive
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff" })