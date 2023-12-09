local langs = {
  { "fatih/vim-go" },
  {
    'rust-lang/rust.vim',
    -- lazy = true,
  },
  {
    'simrat39/rust-tools.nvim',
    -- lazy = true,
    config = function()
      require('users.opts.rust-tools-opt.rto').config()
    end,
  },
  { 'mfussenegger/nvim-jdtls' },
  { 'mzlogin/vim-markdown-toc' },
  {
    'saecki/crates.nvim',
    version = 'v0.3.0',
    -- lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end
  },
  -- 还是直接用typora吧
  -- { "ellisonleao/glow.nvim", branch = 'main' },
}

return langs
