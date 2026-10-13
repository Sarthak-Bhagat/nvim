-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

vim.diagnostic.config { virtual_text = false }

-- Run a project's own pinned tool when it has one (uv puts it in .venv), so the editor
-- reports what the project's lint gate reports; otherwise Mason's copy.
local function venv_first(tool, args)
  return function(dispatchers, config)
    local pinned = config.root_dir and (config.root_dir .. "/.venv/bin/" .. tool)
    local bin = (pinned and vim.uv.fs_stat(pinned)) and pinned or tool
    return vim.lsp.rpc.start(vim.list_extend({ bin }, args), dispatchers)
  end
end

-- ty is the type checker urd and scrobd gate on; ruff serves lint diagnostics and fixes.
vim.lsp.config("ty", { cmd = venv_first("ty", { "server" }) })
vim.lsp.config("ruff", { cmd = venv_first("ruff", { "server" }) })
vim.lsp.enable { "ty", "ruff" }

-- ruff offers "Fix all" and "Organize imports" (kind source.*) at every cursor position, so
-- lspsaga's lightbulb lit on every line of every Python file; both already run on save.
-- A request that names the kinds it wants still gets them -- <leader>la does -- and one that
-- names none, like the lightbulb's, gets everything except source.*. ruff's per-problem
-- fixes are kind quickfix, so they still light it.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "ruff" or client.source_actions_on_request then
      return
    end
    client.source_actions_on_request = true
    local request = client.request
    client.request = function(self, method, params, handler, bufnr)
      local named = params and params.context and params.context.only
      if method == "textDocument/codeAction" and not named and handler then
        local inner = handler
        handler = function(err, result, ...)
          result = result
            and vim.tbl_filter(function(action)
              return not vim.startswith(action.kind or "", "source")
            end, result)
          return inner(err, result, ...)
        end
      end
      return request(self, method, params, handler, bufnr)
    end
  end,
})
