lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.cmp.mapping['<C-k>'] = nil
-- 移除cmp的tab补全，防止和tabnine冲突。虽然没用吧(指cmp本身的tab没啥实际用处)，但是为什么tabnine会无法设置呢?
lvim.builtin.cmp.mapping["<Tab>"] = nil
