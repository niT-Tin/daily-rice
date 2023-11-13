local langs = {
  { "fatih/vim-go" },
  { 'rust-lang/rust.vim' },
  {
    'simrat39/rust-tools.nvim',
    config = function()
      require('users.opts.rust-tools-opt.rto').config()
    end,
  },
  { 'mfussenegger/nvim-jdtls' },
  { 'mzlogin/vim-markdown-toc' },
  {
    'saecki/crates.nvim',
    version = 'v0.3.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end
  },
  { "ellisonleao/glow.nvim", branch = 'main' },
}

return langs
