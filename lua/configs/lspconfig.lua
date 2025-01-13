-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- local lspconfig = require "lspconfig"

-- lspconfig.gleam.setup {}
vim.diagnostic.config { virtual_text = false }
