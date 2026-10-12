return {
  "preservim/nerdtree",
  cmd = "NERDTreeToggle",           -- carrega só quando chamar o comando
  keys = {
    { "<leader>e", "<cmd>NERDTreeToggle<cr>", desc = "Toggle NERDTree" },
  },
  config = function()
    -- Opcional: fecha nerdtree se for o último buffer aberto
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "nerdtree" and vim.fn.winnr("$") == 1 then
          vim.cmd.quit()
        end
      end,
    })
  end,
}
