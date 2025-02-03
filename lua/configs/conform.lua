local fn = vim.fn
-- Helper function to detect if the project is a Django project
local function get_html_formatter()
  local dir = fn.getcwd()
  while dir ~= "/" do
    if fn.glob(dir .. "/manage.py") ~= "" then
      return { "djlint" }
    end
    dir = fn.fnamemodify(dir, ":h")
  end
  return { "prettier" }
end

require("conform").setup {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    rust = { "rustfmt" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    -- htmldjango = { "djlint" },
    html = get_html_formatter(),
    -- Fallback for all other filetypes
    -- ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  -- Format on save configuration
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },

  -- Log level and notifications
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  notify_no_formatters = true,
}
