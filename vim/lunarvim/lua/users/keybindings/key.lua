lvim.keys.normal_mode = {
  ["<Leader>n"] = ":SymbolsOutline<CR>",
  -- ["<Leader>a"] = ":Autoformat<CR>",
  -- ["<Leader>an"] = ":AutoformatLine<CR>",
  -- ["<leader><leader>"] = "<Plug>(easymotion-prefix)",
  -- ["<Leader><Leader>s"] = "<Plug>(easymotion-s)",
  -- ["<Leader><Leader>w"] = "<Plug>(easymotion-w)",
  --[[
    easymotion快捷键映射
  ]]
  -- ["<Leader><Leader>s"] = ":<C-U>call EasyMotion#S(1,0,2)<CR>",
  -- ["<Leader><Leader>s2"] = ":<C-U>call EasyMotion#S(2,0,2)<CR>",
  -- ["<Leader><Leader>sn"] = ":<C-U>call EasyMotion#S(-1,0,2)<CR>",
  -- ["<Leader><Leader>w"] = ":<C-U>call EasyMotion#WB(0,0)<CR>",
  -- ["<Leader><Leader>W"] = ":<C-U>call EasyMotion#WBW(0,0)<CR>",
  ["<Leader>r"] = ":LspRestart<CR>",
  ["<Leader>bk"] = ":BufferKill<CR>",
  -- ["<Leader>o"] = ":set fdm=syntax<CR>",
  -- ["<Leader><Leader>p"] = ":Glow<CR>",
  ["<Leader>zn"] = ":TZNarrow<CR>",
  ["<Leader>zf"] = ":TZFocus<CR>",
  ["<Leader>zm"] = ":TZMinimalist<CR>",
  ["<Leader>za"] = ":TZAtaraxis<CR>",
  -- 开启画图的快捷键
  ["<Leader>sv"] = ":lua require('users.opts.venn.opt').Toggle_venn()<CR>",
}


vim.cmd 'xmap ga <Plug>(EasyAlign)'
vim.cmd 'nmap ga <Plug>(EasyAlign)'
vim.keymap.set("i", "jk", "<Esc>")
lvim.lsp.buffer_mappings.insert_mode['<Tab>'] = nil
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('v', 'b', '<Plug>(DBUI_ExecuteQuery)')
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end)
-- 插入模式下光标移动
-- vim.keymap.set("i", "<C-h>", "<Left>")
-- vim.keymap.set("i", "<C-l>", "<Right>")
-- vim.keymap.set("i", "<C-j>", "<Down>")
-- vim.keymap.set("i", "<C-k>", "<Up>")
