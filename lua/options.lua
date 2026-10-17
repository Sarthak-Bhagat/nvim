require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt
local api = vim.api
local g = vim.g

opt.cursorline = true
opt.relativenumber = true

opt.termguicolors = true
o.foldcolumn = "0"
o.shell = "/usr/bin/fish"

o.autochdir = true
api.nvim_create_autocmd("FileType", {
  pattern = "gleam",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

-- Make :write create missing parent directories, as `:write ++p` does. Registered before
-- the conform autocmd below: formatters run with the file's directory as cwd, so it has to
-- exist by then. FileWritePre covers `:'<,'>write new/dir/file`. URIs (oil://, scp://) are
-- not paths.
api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
  group = api.nvim_create_augroup("MkdirOnWrite", { clear = true }),
  callback = function(args)
    if args.match == "" or args.match:find "^%a[%w+.-]*://" then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(args.match, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

if g.neovide then
  -- Put anything you want to happen only in Neovide here
  g.neovide_opacity = 0.75
  g.neovide_hide_mouse_when_typing = true
  -- vim.g.neovide_fullscreen = true
  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_scale_factor = 0.95
end
