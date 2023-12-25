local databases = {
  -- { 'tpope/vim-dadbod', },
  {
    'niT-Tin/vim-dadbod',
    branch = 'addMySQLAdapterCommandGlobalVariable',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'niT-Tin/vim-dadbod',                   lazy = true,                      branch = 'addMySQLAdapterCommandGlobalVariable' },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql", "mysql", "plsql"
        },
        command = [[
    lua require('cmp').setup.buffer({
      sources = {
        { name = 'vim-dadbod-completion' }
      }
    })
  ]]
      })
    end,
  },
}

return databases
