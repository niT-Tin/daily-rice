local dashboard = require('alpha.themes.dashboard')
require('alpha.term')
dashboard.section.footer.val = {
  "          永远保持谦逊，但不妄自菲薄",
  "Always be humble, but don't belittle yourself",
}

dashboard.section.buttons.val = {
  dashboard.button("f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>"),
  dashboard.button("n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>"),
  dashboard.button("p", lvim.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>"),
  dashboard.button("r", lvim.icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
  -- dashboard.button("t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"),
  dashboard.button("c", lvim.icons.ui.Gear .. "  Configuration",
    "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>"),
  dashboard.button("q", lvim.icons.ui.Close .. "  Quit", "<CMD>quit<CR>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "AlphaShortcut"
dashboard.section.buttons.opts.hl = "AlphaButtons"

local width = 50 -- 实际图片转换设置为52
-- 这里如果不用17的话，会让我这个图片遮住下面的按钮(具体可以设置图片大小，但是还是不相改图片大小)
-- https://dom111.github.io/image-to-ansi/ 这个网站可以把图片转成ansi码
local height = 17 -- 实际图片转换设置为40
local asciiart = "batman"
dashboard.section.terminal.command = "cat | " .. vim.fn.stdpath('config') .. '/scripts/asciiart/' .. asciiart
dashboard.section.terminal.width = width
dashboard.section.terminal.height = height
dashboard.section.terminal.opts.redraw = true

-- dashboard.section.header.val = "🔥  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞  🔥"
dashboard.section.header.val = "🦇  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞   🦇"

dashboard.config.layout = {
  -- { type = "padding", val = 1 },
  dashboard.section.terminal,
  { type = "padding", val = 4 },
  dashboard.section.header,
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

lvim.builtin.alpha.dashboard = dashboard
-- lvim.builtin.alpha.active = true
-- lvim.builtin.alpha.mode = "dashboard"
-- 删除dashboard中的一些按钮这里是推出选项
-- 具体可以看 $HOME/.local/share/lunarvim/lvim/lua/lvim/core/alpha/dashboard.lua
-- 同时也不能直接使用q退出，得使用:q
-- table.remove(lvim.builtin.alpha.dashboard.section.buttons.entries, 7)
-- coding hippo
-- lvim.builtin.alpha.dashboard.section.header.val = {
--   "                                              ",
--   "                .o;.   ..   .c'.",
--   "                 .',,;,cccccoc.",
--   "                . ':;,...cox0.'.",
--   "                .''',,;cc::;:od.",
--   "              .::::cclloodddkxxxo",
--   "              :::;::clloooxkokxnwc",
--   "              ,;;;clooddddxko0knn,",
--   "               .',:lol:::coxxdk0'",
--   "              .:;,,::cclllookoxnd.",
--   "             ';:;,,,:oodxxkokxnnxk.",
--   "           .:,,',,;cln0xk0k0kkkkcxkk.",
--   "          .c::lo,,lokwnwnwwnkod;:dknd",
--   "          .,,,cdo,xxwwmmmmmwxo;;;cxod",
--   "           '..,oc':do000k000o;,;..:oc....",
--   "      .............'''''''',',,',,',,;:,",
--   "        .:::::ccccccccccccccccccccccc,",
--   "           ........................",
--   "                ..............",
--   "                    ......",
-- }
-- batman
-- lvim.builtin.alpha.dashboard.section.header.val = {
--   "...........'''','','';''''',,,,,,cl:;,,;:;;,",
--   "''''''',,,;;,,;;;;;;:c;;;;;::::::::::::ccc::",
--   ",,;,;;:::ccc:cccclll;llllllo,llccccc:::::cll",
--   ":ccccccccclllloooddd..;;:::..dooollccccccccc",
--   "llllllllloddddxxxkOO.':odol:,dxxddoollllllll",
--   "ooooodddddxxkkkO00KN..';c:,'.oOOkkxddoooooll",
--   "oodddxxxkkOOO00KKKXW'       .dK00OOkxxddoool",
--   "ddxxxkOO0000KKKXXNX,         dXKKK00Okxxdddd",
--   "xkkOO00KKKKKXXKkc:.       .. lXXXXKK00Okkkxx",
--   "OO000KKKXXXXk;. .:c.  ,..:c. .'coc',xXK0OOkk",
--   "00KKKX0o;,;l:,...,xc   ...   .. .  .;xdxkOOO",
--   "KKKX0:..:OXNNKl.           '. ...ldc,c:..cOO",
--   "KKXd..'xNNKOd:....:::'''..'.  cOXXd;c;..  oO",
--   "KKok;.,c;',.  .,lNWXx:;lddoc'.:c:,.. .'  .;0",
--   "KKxk....       .ol..,'...            lO  .d0",
--   "XKO:    .   .  .';lkXNO,.,,'.   ......c. .o0",
--   "Kkdl     :,'.   ..;:cool,,'...,.     . ....o",
--   "oo:..  ..dx.      ......    ,c...  ...  . ..",
--   "lc:.....oKl.     .lOOkdc;...   ,'.         .",
-- }

