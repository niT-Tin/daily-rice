vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    local ok, cmp = pcall(require, 'cmp')
    if not ok then
      return
    end
    cmp.setup.buffer({ sources = { { name = "crates" } } })
  end,
})
require('users.opts.neovide-vars.opt')
