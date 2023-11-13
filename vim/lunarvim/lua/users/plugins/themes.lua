local themes = {}
themes = {
  -- [[ vim themes
  { 'Mofiqul/vscode.nvim' },
  { 'shaeinst/roshnivim-cs' },
  { 'savq/melange-nvim' },
  -- like jetbrain
  { 'doums/darcula' },
  { 'Rigellute/shades-of-purple.vim', },
  { "lunarvim/Onedarker.nvim", },
  { "olimorris/onedarkpro.nvim", },
  { 'tiagovla/tokyodark.nvim' },
  { 'sainnhe/everforest' },
  {
    'Shatur/neovim-ayu',
    config = function()
      require('ayu').setup({
        mirage = true,
        overrides = {},
      })
    end
  },
  {
    'hardhackerlabs/theme-vim',
    config = function()
      -- vim.cmd.colorscheme 'hardhacker'
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {'projekt0n/github-nvim-theme'},
  { "oxfist/night-owl.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  -- idea carbon theme for nvim
  { "michaeldyrynda/carbon" },
}

return themes
