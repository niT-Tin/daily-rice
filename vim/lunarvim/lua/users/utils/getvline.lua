local M = {}

local trans = require('Trans')

-- 返回visual模式下选中的行
---@return nil[]|string[]
M.getvline = function()
  -- '<'>只有在退出visual模式后才会被设置
  -- local vstart = vim.fn.getpos("'<")
  -- local vend = vim.fn.getpos("'>")
  local vstart = vim.fn.getpos('v')
  local vend = vim.fn.getpos('.')
  if #vstart < 3 or not vstart then
    return { "empty start" }
  end
  if #vend < 3 or not vend then
    return { "empty end" }
  end
  return vim.fn.getline(vstart[2], vend[2])
end

-- 返回选中的段落
---@return nil[]|string[]
M.getvpara = function()
  -- 执行vip获得段落行
  vim.cmd("normal! vip")
  trans.translate()
  vim.api.nvim_input('<Esc>')
  return {"empty"}
end

-- 移动到下一个paragraph的开头并执行getvpara并且退出visual模式
M.move = function()
  vim.api.nvim_input('}')
  vim.api.nvim_input('j')
  M.getvpara()
  -- INFO: 将获得的行转到翻译插件
  -- 并且将翻译之后的文本放到剪贴板
  -- 或者默认寄存器，可以直接p
  -- 整体效果参考lsp下使用k和K查看定义和进入文档的效果
  -- 不用了，可以直接调用翻译插件的函数
end

-- 添加mapping
M.startMode = function()
  -- 添加mapping
  -- j移动到下一个paragraph的开头并执行getvpara并且退出visual模式
  vim.api.nvim_set_keymap('n', '<C-i>', ':lua require("users.utils.getvline").move()<CR>',
    { noremap = true, silent = true })
end

M.stopMode = function()
  -- 删除mapping
  vim.api.nvim_del_keymap('n', '<C-i>')
end


return M
