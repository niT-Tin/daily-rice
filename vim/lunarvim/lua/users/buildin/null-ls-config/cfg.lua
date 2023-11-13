local M = {}

M.config = function()
  local ok, null_ls = pcall(require, 'null-ls')
  if not ok then
    return
  end

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } });
      formatting.black.with({ extra_args = { "--fast" } });
      formatting.stylua;
      diagnostics.eslint_d;
    }
  })

end

return M
