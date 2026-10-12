-- ~/.config/nvim/lua/plugins/fzf.lua
return {
  "junegunn/fzf.vim",
  dependencies = {
    { "junegunn/fzf", build = "./install --all" },
  },
  cmd = {
    "Files", "GFiles", "Buffers", "Lines", "BLines",
    "Rg", "History", "Commands", "Maps", "Helptags", "Filetypes", "Colors"
  },
  keys = {
    { "<leader>ff", "<cmd>Files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Rg<cr>",    desc = "Ripgrep" },
    { "<leader>fb", "<cmd>Buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>History<cr>", desc = "History" },
  },
  init = function()
    -- Desativa mapeamentos default (<C-p>, <C-b>...) para não colidir
    vim.g.fzf_vim = { default_mappings = 0 }
  end,
}