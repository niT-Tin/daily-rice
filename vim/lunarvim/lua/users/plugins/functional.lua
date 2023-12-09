local functional = {
  -- 提示代码警告等
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- 顺滑滑动
  {
    "karb94/neoscroll.nvim",
    -- 官方文档已经没有这个选项了, 而且加了还会有小问题
    -- event = "WinScrolled",
    config = function()
      local scroll_opts = require('users.opts.scroll.opts')
      require('neoscroll').setup(scroll_opts)
    end,
  },
  -- 光标到上一次离开时的位置
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  -- 于预览本机 LSP 的 goto 定义、类型定义、实现和浮动窗口中的引用调用。
  {
    "rmagatti/goto-preview",
    lazy = true,
    config = function()
      require('goto-preview').setup {
        width = 120,              -- Width of the floating window
        height = 25,              -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false,            -- Print debug information
        opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end
  },
  -- [[
  -- 一个用于插入代码模板的插件
  -- 用法: Template {要插入的文件名} {模板目录下没有后缀的模板文件名}
  -- eg: Template main.c c_main
  -- 这里生成一个main.c文件，并且将temp_dir目录下的c_main.c的文件模板内容插入main.c文件中
  -- ]]
  {
    'glepnir/template.nvim',
    cmd = { 'Template', 'TemProject' },
    lazy = true,
    config = function()
      require('template').setup({
        -- config in there
        temp_dir = '~/.config/lvim/template_dir',
        author = 'liuzehao/LazyHippo',
        email = 'liuzehao3@outlook.com'
      })
      -- require('telescope').load_extension('find_template')
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local treesitter_context_opt = require('users.opts.treesitter-context.opts')
      require('treesitter-context').setup(treesitter_context_opt)
    end
  },
  { 'nvim-treesitter/playground' },
  {
    -- html tag自动闭合命名
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  --  如果出现Python Error: unknown function _wilder_python_search
  --  使用 :UpdateRemotePlugins
  --  太卡了，不用了，真的是
  -- {
  --   'gelguy/wilder.nvim',
  --   config = function()
  --     require('users.opts.wilder.opt').config()
  --   end,
  -- },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  { 'haringsrob/nvim_context_vt' },
  {
    "simrat39/symbols-outline.nvim",
    -- lazy = true,
    config = function()
      require('symbols-outline').setup()
    end
  },
  { "github/copilot.vim" },
  -- 自己写的用于创建springboot项目的插件
  -- {
  --   'niT-Tin/springboot-start.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'MunifTanjim/nui.nvim',
  --   },
  --   config = function()
  --     require('springboot-start').setup({
  --       input = {
  --         prompt = "🔍 "
  --       }
  --     })
  --   end
  -- },
  -- 画ascii图(diagram)
  {
    'jbyuki/venn.nvim',
    -- lazy = true,
  },
  -- {
  --   "dnlhc/glance.nvim",
  -- config = function()
  --   require('glance').setup()
  -- end,
  -- },
}

return functional

