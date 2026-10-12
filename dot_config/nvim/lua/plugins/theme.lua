-- ~/.config/nvim/lua/plugins/theme.lua
return {
  "chriskempson/base16-vim",
  lazy = false,
  priority = 1000,
  config = function()
    -- vim.cmd.colorscheme("base16-tomorrow") -- comentado: precisa true-color
    vim.cmd.colorscheme("habamax") -- nativo, 256-color, funciona em qualquer terminal
  end,
}