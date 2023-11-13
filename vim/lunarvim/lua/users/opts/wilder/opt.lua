local M = {}

M.config = function()
  local ok, wilder = pcall(require, 'wilder')
  if (not ok) then
    return;
  end
  wilder.setup({
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    previous_key = '<C-p>',
  })

  --[[
  -- 因为多次设置popupmenu_renderer会让最后一次设置覆盖之前的，所以这里先吧border
  -- theme定义好，再往选项里面插入图标和透明度选项
  --]]
  -- wilder.set_option('renderer', wilder.popupmenu_renderer({
  --   left = { ' ', wilder.popupmenu_devicons() },
  --   right = { ' ', wilder.popupmenu_scrollbar() },
  --   pumblend = 20,
  -- }))


  local border_theme = wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal',
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })

  border_theme['left'] = { ' ', wilder.popupmenu_devicons() }
  border_theme['right'] = { ' ', wilder.popupmenu_scrollbar() }
  border_theme['pumblend'] = 80

  wilder.set_option('renderer', wilder.popupmenu_renderer(
    border_theme
  ))
end

return M
