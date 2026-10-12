-- ~/.config/nvim/init.lua

-- 1. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Leader ANTES de carregar plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 3. Carrega specs de plugins
require("lazy").setup("plugins", {
  change_detection = { notify = false },
  performance = {
    rtp = { disabled_plugins = { "netrw", "tohtml", "tutor" } },
  },
})

-- 4. Configs gerais
require("config.options")
require("config.keymaps")