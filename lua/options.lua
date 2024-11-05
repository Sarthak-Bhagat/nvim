require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true
vim.opt.relativenumber = true
-- vim.opt.clipboard = "unnamedplus"
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format { bufnr = args.buf }
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- vim.opt.guicursor = "n:block-blinkwait1000-blinkon500-blinkoff500"
vim.opt.termguicolors = true
vim.o.foldcolumn = "0"

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
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
