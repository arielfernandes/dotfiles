-- ~/.config/nvim/lua/plugins/airline.lua
return {
  "vim-airline/vim-airline",
  dependencies = { "vim-airline/vim-airline-themes" },
  config = function()
    vim.g.airline_theme = "base16"
    -- vim.g["airline#extensions#tabline#enabled"] = 1 -- habilita tabline se quiser
  end,
}