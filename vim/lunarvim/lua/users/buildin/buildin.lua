local lvim_buildins = {
  'users.buildin.basic',
  'users.buildin.dashboard',
  'users.buildin.mapping',
  'users.buildin.themes',
  'users.buildin.nvimtree',
  'users.buildin.others',
  'users.buildin.treesitter',
  'users.buildin.gitsign',
  'users.buildin.fold',
  'users.buildin.indent',
  'users.buildin.lsp',
}

for _, v in ipairs(lvim_buildins) do
  local ok, _ = pcall(require, v)
  if not ok then
    print(v .. "loaded error in buildin")
    goto continue
  end
  ::continue::
end
