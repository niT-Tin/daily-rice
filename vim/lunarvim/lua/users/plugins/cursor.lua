local cursors = {
  { 'junegunn/vim-easy-align' },
  -- 我自己来format,真的是
  -- { "Chiel92/vim-autoformat" },
  -- { "easymotion/vim-easymotion" },
  { "tpope/vim-surround" },
  { "wakatime/vim-wakatime" },
  { 'mg979/vim-visual-multi' },
  {
    -- 和easymotion一样
    "phaazon/hop.nvim",
    lazy = true,
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar1<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
}

return cursors
