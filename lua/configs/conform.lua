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

-- Whether the nearest pyproject.toml declares [section]. A repo opts into formatting on
-- save by declaring it in its one-off format commit (urd and scrobd, 2026-10-13); a repo
-- still hand-formatted is left alone, so a save never reformats a whole file.
local function declares(section)
  return function(_, ctx)
    local pyproject = vim.fs.find("pyproject.toml", { upward = true, path = ctx.dirname })[1]
    if not pyproject then
      return false
    end
    for line in io.lines(pyproject) do
      if line == "[" .. section .. "]" then
        return true
      end
    end
    return false
  end
end

local venv_ruff = require("conform.util").find_executable({ ".venv/bin/ruff" }, "ruff")

require("conform").setup {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    rust = { "rustfmt" },
    -- ruff_format and djlint run only where the repo declares them; see `declares`.
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    htmldjango = { "djlint" }, -- Jinja templates, e.g. urd's
    html = get_html_formatter(),
    -- Fallback for all other filetypes
    -- ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  -- A project's pinned tools (uv's .venv), so the result matches the project's gate.
  formatters = {
    ruff_fix = { command = venv_ruff },
    ruff_organize_imports = { command = venv_ruff },
    ruff_format = { command = venv_ruff, condition = declares "tool.ruff.format" },
    -- Lua's marker is the stylua config itself: without one stylua's default is tabs.
    stylua = {
      condition = function(_, ctx)
        return vim.fs.find({ ".stylua.toml", "stylua.toml" }, { upward = true, path = ctx.dirname })[1] ~= nil
      end,
    },
    djlint = {
      command = require("conform.util").find_executable({ ".venv/bin/djlint" }, "djlint"),
      -- Not [tool.djlint]: that is lint config, present before a repo is formatted.
      condition = declares "tool.ruff.format",
    },
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
