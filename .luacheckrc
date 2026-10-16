-- nvim config: Lua 5.1 / LuaJIT, with nvim's own global.
std = "luajit"
globals = { "vim" }
-- snacks.nvim defines `Snacks` at startup (lazy = false, priority 1000); read only here.
read_globals = { "Snacks" }
max_line_length = 120
