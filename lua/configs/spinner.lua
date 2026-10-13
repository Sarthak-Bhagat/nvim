-- spinner.nvim: a spinner beside the cursor while an LSP request he is waiting on is in
-- flight. The 200 ms delay keeps fast replies from flashing it, so it only appears
-- when the server is actually thinking. LSP progress is not drawn here: NvChad's
-- statusline and noice already show it. project.nvim uses spinner.nvim for its own
-- cursor spinner (configs.project).
local spinner = require "spinner"

spinner.setup {
  initial_delay_ms = 200,
  ttl_ms = 10000, -- never spin forever on a request that is dropped
}

spinner.config("lsp_request", {
  kind = "cursor",
  attach = {
    lsp = {
      request = {
        "textDocument/hover",
        "textDocument/definition",
        "textDocument/references",
        "textDocument/implementation",
        "textDocument/typeDefinition",
      },
    },
  },
})
