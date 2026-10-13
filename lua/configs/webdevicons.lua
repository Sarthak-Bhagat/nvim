-- Icons NvChad's set lacks, coloured from the active base46 theme. Extends NvChad's own
-- devicons options (plugins/init.lua passes them in) rather than replacing them: an
-- earlier `config` here replaced NvChad's setup and these overrides were never applied.
return function(opts)
  local c = require("base46").get_theme_tb "base_30"
  opts.override = vim.tbl_extend("force", opts.override or {}, {
    gql = { icon = "", color = "#e535ab", cterm_color = "199", name = "GraphQL" },
  })
  opts.override_by_filename = vim.tbl_extend("force", opts.override_by_filename or {}, {
    [".ecrc"] = { icon = "", name = "EditorConfigChecker", color = c.green },
    [".envrc"] = { icon = "", name = "envrc", color = c.yellow },
    [".editorconfig"] = { icon = "", name = "EditorConfig", color = c.green },
    [".luacheckrc"] = { icon = "󰢱", name = "LuacheckRC", color = c.blue },
  })
  return opts
end
