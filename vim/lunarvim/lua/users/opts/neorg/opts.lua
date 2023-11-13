local M = {}

M.config = function()
  local ok, neorg = pcall(require, 'neorg')
  if not ok then
    return
  end

  neorg.setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "~/Notes/neorg",
          }
        }
      }
    }
  }
end

return M
