--[[
-- 这里是为了解决因为neovim升级到0.9.0之后，clangd总是warning的问题
-- warning: multiple different client offset_encodings detected for buffer, this is not supported yet
--]]
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.offsetEncoding = "utf-8"
capabilities.offset_encoding = "utf-8"
capabilities.clang = {}
capabilities.clang.offsetEncoding = "utf-8"
capabilities.clang.offset_encoding = "utf-8"
lspconfig.clangd.setup { capabilities = capabilities }
