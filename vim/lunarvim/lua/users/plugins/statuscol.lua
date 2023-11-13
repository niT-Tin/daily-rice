local statuscol = {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      -- local ufo_opts = require('users.opts.folding.opt')
      require('ufo').setup({})
    end
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local cfg = require('users.opts.statuscol.opt')
      require("statuscol").setup(cfg)
    end,
  },
}

return statuscol
