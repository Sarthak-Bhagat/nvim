local lint = require "lint"

-- Python lint comes from the ruff language server (configs.lspconfig); these cover
-- what no server does.
lint.linters_by_ft = {
  htmldjango = { "djlint" }, -- Jinja templates, e.g. urd's
  dockerfile = { "hadolint" },
}

-- A project's pinned djlint (uv's .venv), as for ruff and ty, so it reads the same
-- version and the project's [tool.djlint] profile.
lint.linters.djlint.cmd = function()
  local root = vim.fs.root(0, ".venv")
  local pinned = root and (root .. "/.venv/bin/djlint")
  return (pinned and vim.uv.fs_stat(pinned)) and pinned or "djlint"
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
