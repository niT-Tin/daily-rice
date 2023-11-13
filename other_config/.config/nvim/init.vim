set nu
set relativenumber
syntax on
filetype plugin indent on
inoremap jk <Esc>
let mapleader = " "
call plug#begin()

" 格式化文本插件
Plug 'junegunn/vim-easy-align'
" 配合easymotion使用
Plug 'tpope/vim-repeat'
" 添加或删除surround 如引号等
Plug 'tpope/vim-surround'
" 转跳插件
Plug 'easymotion/vim-easymotion'
" 以下为语言服务插件
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" go语言插件
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" rust语言插件
" Rust语言服务器RLS已经被弃用， 取而代之的是rust-analyzer
Plug 'rust-lang/rust.vim'
" 语法高亮插件
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" 注释插件
Plug 'numToStr/Comment.nvim'
" theme 主题
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'navarasu/onedark.nvim'
" 时间统计插件
Plug 'wakatime/vim-wakatime'
" markdown渲染插件
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
" 括号自动补全插件
Plug 'windwp/nvim-autopairs'
" 文件树插件以及图标插件
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" 缩进插件
Plug 'lukas-reineke/indent-blankline.nvim'
" 函数显示插件
Plug 'liuchengxu/vista.vim'
" 彩虹括号插件
Plug 'luochen1990/rainbow'
" markdown tagbar (markdown的大纲显示)
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'
" git 插件
Plug 'lewis6991/gitsigns.nvim'
" lsp dap等
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

call plug#end()
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
lua require('Comment').setup()
lua << EOF
require("nvim-autopairs").setup {}
EOF

lua << EOF
require("mason").setup()
EOF

lua << EOF
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
--    char_highlight_list = {
--        "IndentBlanklineIndent1",
--        "IndentBlanklineIndent2",
--        "IndentBlanklineIndent3",
--        "IndentBlanklineIndent4",
--        "IndentBlanklineIndent5",
--        "IndentBlanklineIndent6",
--    },
}
EOF
" colorscheme tokyonight
" vimrc

lua << EOF
-- init.lua
-- empty setup using defaults: add your own options
-- OR

-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    -- height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
--  filesystem_watchers = {
--    enable = false,
--    interval = 100,
--  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
} -- END_DEFAULT_OPTS
EOF

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>h :Vista!!<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
" setting theme
" Vim Script
let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
" colorscheme catppuccin
" 使用onedark主题
colorscheme onedark
" 配置onedark主题
" let g:onedark_config = {
" 	\'style': 'dark',
" 	\'style': 'darker',
" 	\'style': 'cool',
" 	\'style': 'deep',
" 	\'style': 'warm',
" 	\'style': 'warmer',
" \}
let g:onedark_config = {
    \ 'style': 'darker',
\}
colorscheme onedark
" lsp快捷键配置
" gd 转跳到定义位置
nmap <buffer> gd <plug>(lsp-definition)
" gs 文档搜索
nmap <buffer> gs <plug>(lsp-document-symbol-search)
" gS 当前工作空间搜索
nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
" gr 显示引用(即调用位置)
nmap <buffer> gr <plug>(lsp-references)
" gi 转跳到实现
nmap <buffer> gi <plug>(lsp-implementation)
" gt 转跳到类型定义
nmap <buffer> gt <plug>(lsp-type-definition)
" 重命名
nmap <buffer> <leader>rn <plug>(lsp-rename)
" [g 上一次诊断处
nmap <buffer> [g <plug>(lsp-previous-diagnostic)
" g] 下一次诊断处
nmap <buffer> ]g <plug>(lsp-next-diagnostic)
" 鼠标悬停效果
nmap <buffer> K <plug>(lsp-hover)

" 启用彩虹括号
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF

nnoremap j gj
nnoremap k gk

