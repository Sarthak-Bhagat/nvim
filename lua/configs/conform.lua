-- Helper function to detect if the project is a Django project
local function is_django_project()
  local is_django = false
  -- Check for the presence of manage.py in the current directory or any parent directory
  local current_dir = vim.fn.getcwd()
  while current_dir ~= "/" do
    if vim.fn.glob(current_dir .. "/manage.py") ~= "" then
      is_django = true
      break
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end
  return is_django
end

require("conform").setup {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    rust = { "rustfmt", lsp_format = "fallback" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    html = function()
      -- Check if we're in a Django project
      if is_django_project() then
        return { "djlint" }
      else
        return { "prettier" }
      end
    end,
    -- Fallback for all other filetypes
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },

  -- Default format options
  default_format_opts = {
    lsp_format = "fallback",
  },

  -- Format on save configuration
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },

  -- Format after save configuration
  format_after_save = {
    lsp_format = "fallback",
  },

  -- Log level and notifications
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  notify_no_formatters = true,
}
