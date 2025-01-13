local lint = require "lint"
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

lint.linters_by_ft = {
  go = { "goimports" },
  rust = { "rustfmt" },
  python = { "ruff" },
  html = get_html_formatter(),
  -- Fallback for all other filetypes
  ["*"] = { "codespell" },
  ["_"] = { "trim_whitespace" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
