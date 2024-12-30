require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt
local api = vim.api

opt.cursorline = true
opt.relativenumber = true

opt.termguicolors = true
o.foldcolumn = "0"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gleam",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_transparency = 0.75
  vim.g.neovide_hide_mouse_when_typing = true
  -- vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_scale_factor = 0.95
end
