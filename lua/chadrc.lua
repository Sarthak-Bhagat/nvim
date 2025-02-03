-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "gatekeeper",
  transparency = true,
  lsp_semantic_tokens = true,

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "󰋚 Recent Files", keys = "r", cmd = "Telescope oldfiles" },
    { txt = "󰙅 File Browser", keys = "e", cmd = "NvimTreeToggle" },
    { txt = "󰈞 Find File", keys = "f", cmd = "Telescope find_files" },
    { txt = "󰈔 New File", keys = "n", cmd = "new" },
    { txt = "󰞋 Search Help", keys = "h", cmd = "Telescope help_tags" },
    {
      txt = "󱁻 Config",
      keys = "c",
      cmd = "lua require('telescope.builtin').find_files({cwd = '~/.config/nvim/'})",
    },
    { txt = "󰢛 Open Mason", keys = "m", cmd = "Mason" },
    { txt = "󰒲 Open Lazy", keys = "l", cmd = "Lazy" },
    { txt = "󰗼 Quit", keys = "q", cmd = "qa" },
    { txt = "━", hl = "NvDashLazy", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "󱐋 Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },
    { txt = "━", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false,
    },
  },
}
return M
