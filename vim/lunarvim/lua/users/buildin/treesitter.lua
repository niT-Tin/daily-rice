lvim.builtin.treesitter.highlight.enable = true
-- bash被忽略，貌似并不影响显示高亮
lvim.builtin.treesitter.ignore_install = {
  "bash",
  "haskell",
  "make",
  "python",
}
lvim.builtin.treesitter.ensure_installed = {
  -- "bash", 有显示问题
--  "c",
--  "javascript",
--  "json",
--  "lua",
--  "typescript",
--  "tsx",
--  "css",
--  "rust",
--  "java",
--  "yaml",
--  "org",
}

lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.treesitter.rainbow.colors = {
  "#E06C75",
  "#E5C07B",
  "#ffd551",
  "#7553bd",
  "#189ff9",
  "#C678DD",
  "#037bfc"
}
