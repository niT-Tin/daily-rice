local M = {}
--[[
  具体配置相关直接看文档
  https://github.com/olimorris/onedarkpro.nvim#configuring-styles
--]]
M.config = function()
  require('onedarkpro').setup({
    -- 此处因为修改Java中注解的颜色为对应的十六进制颜色
    highlights = {
      ["@attribute.java"] = { fg = '#cca22d' },
      -- ["@variable.go"] = { fg = '#eaebe8' },
      -- ["@parameter.go"] = { fg = '#eaebe8' },
      ["@type.go"] = { fg = '#d4af37' },
      ["@type.builtin.go"] = { fg = '#d4af37' },
    }
  })
end

return M
