local emoji = {
  -- emoji picker
  { "stevearc/dressing.nvim" },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  },
  {
    'xiyaowong/telescope-emoji.nvim',
    config = function()
      require('telescope').load_extension("emoji")
    end
  },
}
return emoji
