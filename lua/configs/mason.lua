require("mason").setup()
-- Every server Mason has installed is enabled (automatic_enable defaults to true).
require("mason-lspconfig").setup()

-- Declared here, so a wiped ~/.local/share/nvim/mason heals itself on the next start
-- instead of leaving every buffer silently without a server, as it had since Feb 2026.
-- A project's own .venv copy still wins for ruff, ty and djlint (see configs.lspconfig).
local wanted = {
  "lua-language-server",
  "ruff",
  "ty",
  "djlint",
  "stylua",
  "prettier", -- conform's formatter for plain HTML
  "tree-sitter-cli", -- nvim-treesitter's main branch builds parsers with it
}

local registry = require "mason-registry"
registry.refresh(function()
  for _, name in ipairs(wanted) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)
