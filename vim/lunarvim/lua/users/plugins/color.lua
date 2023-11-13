local colors = {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('users.opts.color.opt').config()
    end
  },
  { "p00f/nvim-ts-rainbow" },
}

return colors
