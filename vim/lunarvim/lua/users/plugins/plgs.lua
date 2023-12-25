lvim.plugins = {
  -- {"github/copilot.vim"},
  -- ]]
  -- { "folke/tokyonight.nvim" },
  -- preview of markdown in terminal
  -- {
  --   'codota/tabnine-nvim',
  --   build = "./dl_binaries.sh",
  --   config = function()
  --     vim.fn.system "echo 'hello world' >> /home/liuzehao/test"
  --     require('tabnine').setup({
  --       disable_auto_comment = true,
  --       accept_keymap = "<C-k>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#808080", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --       log_file_path = nil, -- absolute path to Tabnine log file
  --     })
  --   end
  -- },
  -- {
  --   "tzachar/cmp-tabnine",
  --   build = "./install.sh",
  --   dependencies = "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   config = function()
  --     require('cmp_tabnine.config'):setup({
  --       max_lines = 1000,
  --       max_num_results = 20,
  --       sort = true,
  --       run_on_every_keystroke = true,
  --       snippet_placeholder = '..',
  --       ignored_file_types = {
  --         -- default is not to ignore
  --         -- uncomment to ignore in lua:
  --         -- lua = true
  --       },
  --       show_prediction_strength = false
  --     })
  --   end
  -- },

  -- {
  --   "Pocco81/true-zen.nvim",
  --   config = function()
  --     require("true-zen").setup {}
  --   end,
  -- },
  -- {
  -- 'simrat39/inlay-hints.nvim',
  -- config = function ()
  -- require("inlay-hints").setup()
  -- require("users.opts.inlay-hints.go.opt").config()
  -- end
  -- },
}

local function loads(plgss, ok, errmsg)
  if not ok then
    print(errmsg)
    return
  end
  for _, v in ipairs(plgss) do
    table.insert(lvim.plugins, v)
  end
end

local function loadplgs()
  local plugins = {
    'users.plugins.themes',
    'users.plugins.color',
    'users.plugins.cursor',
    'users.plugins.emoji',
    'users.plugins.functional',
    'users.plugins.games',
    'users.plugins.git',
    'users.plugins.languages',
    'users.plugins.lsp',
    'users.plugins.statuscol',
    'users.plugins.development',
    'users.plugins.databases',
  }
  for _, v in ipairs(plugins) do
    local ok, plugin = pcall(require, v)
    loads(plugin, ok, v .. ' loaded error')
  end
end

loadplgs()
