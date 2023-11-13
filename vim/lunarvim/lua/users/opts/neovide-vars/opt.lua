-- set gui font
-- b: bold
-- i: italic
-- hx: font size
-- 设置neovide字体
vim.o.guifont = "JetBrains Mono:h12:b:i"
-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.9))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 0.95
-- vim.g.transparency = 0.9
-- vim.g.neovide_background_color = "#292a36" .. alpha()
