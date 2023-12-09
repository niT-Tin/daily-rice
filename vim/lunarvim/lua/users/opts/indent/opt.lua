local basic = lvim.builtin.indentlines.options

basic['use_treesitter'] = true;
basic['show_current_context'] = true;
basic['show_current_context_start'] = true;
basic['context_highlight_list'] = {
  "rainbowcol1",
  "rainbowcol2",
  "rainbowcol3",
  "rainbowcol4",
  "rainbowcol5",
  "rainbowcol6",
  "rainbowcol7",
}
vim.g.indent_blankline_context_patterns = {
  "class",
  "^func",
  "method",
  "^if",
  "while",
  "for",
  "with",
  "try",
  "except",
  "arguments",
  "argument_list",
  "object",
  "dictionary",
  "element",
  "table",
  "tuple",
  "do_block",
  "^match",
  "^loop",
}


return basic
