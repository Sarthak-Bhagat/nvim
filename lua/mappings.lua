-- Every key this config defines, in one place: docs/superpowers/specs/2026-10-13-keymaps-design.md.
-- <leader> + group + key. Level one is only / e v x. NvChad's own map file is not loaded,
-- so no key exists that this file does not declare. Every hjkl direction has an arrow twin.
local map = vim.keymap.set
local wk = require "which-key"

local function telescope(picker, opts)
  return function()
    require("telescope.builtin")[picker](opts or {})
  end
end

local function gitsigns(action, ...)
  local args = { ... }
  return function()
    require("gitsigns")[action](unpack(args))
  end
end

-- nvim-dap's functions by name, e.g. dap "continue" or dap "repl.toggle"
local function dap(path)
  return function()
    local fn = require "dap"
    for part in path:gmatch "[^.]+" do
      fn = fn[part]
    end
    fn()
  end
end

local function term(opts)
  return function()
    require("nvchad.term").toggle(opts)
  end
end

wk.add {
  -- Level one: muscle memory
  { "<leader>/", "gcc", desc = "Toggle comment", remap = true },
  { "<leader>/", "gc", desc = "Toggle comment", mode = "x", remap = true },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  {
    "<leader>v",
    function()
      require("nvchad.term").new { pos = "vsp" }
    end,
    desc = "Vertical terminal",
  },
  {
    "<leader>x",
    function()
      Snacks.bufdelete()
    end,
    desc = "Close buffer",
  },

  -- f Find
  { "<leader>f", group = "Find" },
  { "<leader>ff", telescope "find_files", desc = "Files" },
  { "<leader>fr", telescope("oldfiles", { cwd_only = true }), desc = "Recent (this project)" },
  { "<leader>fo", telescope "oldfiles", desc = "Recent (everywhere)" },
  {
    "<leader>fa",
    telescope("find_files", { follow = true, no_ignore = true, hidden = true }),
    desc = "All files, hidden and ignored too",
  },
  {
    "<leader>fg",
    function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end,
    desc = "Grep",
  },
  { "<leader>fw", telescope "grep_string", desc = "Grep word under cursor" },
  { "<leader>fz", telescope "current_buffer_fuzzy_find", desc = "In this buffer" },
  { "<leader>fb", telescope "buffers", desc = "Buffers" },
  { "<leader>fh", telescope "help_tags", desc = "Help" },
  { "<leader>fk", telescope "keymaps", desc = "Keymaps" },
  { "<leader>fc", telescope "commands", desc = "Commands" },
  { "<leader>fm", telescope "marks", desc = "Marks" },
  { "<leader>fR", telescope "registers", desc = "Registers" },
  { "<leader>fM", telescope "man_pages", desc = "Man pages" },
  { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },

  -- g Git
  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
  { "<leader>gj", gitsigns("nav_hunk", "next"), desc = "Next hunk" },
  { "<leader>g<Down>", gitsigns("nav_hunk", "next"), desc = "Next hunk" },
  { "<leader>gk", gitsigns("nav_hunk", "prev"), desc = "Previous hunk" },
  { "<leader>g<Up>", gitsigns("nav_hunk", "prev"), desc = "Previous hunk" },
  { "<leader>gp", gitsigns "preview_hunk", desc = "Preview hunk" },
  { "<leader>gs", gitsigns "stage_hunk", desc = "Stage / unstage hunk" },
  { "<leader>gr", gitsigns "reset_hunk", desc = "Reset hunk" },
  { "<leader>gR", gitsigns "reset_buffer", desc = "Reset buffer" },
  { "<leader>gl", gitsigns "blame_line", desc = "Blame line" },
  { "<leader>gd", gitsigns("diffthis", "HEAD"), desc = "Diff against HEAD" },
  { "<leader>go", telescope "git_status", desc = "Changed files" },
  { "<leader>gb", telescope "git_branches", desc = "Branches" },
  { "<leader>gc", telescope "git_commits", desc = "Commits" },

  -- l LSP: only what nvim has no built-in for (K, grn, gra, grr, gri, grt, gO, [d ]d are)
  { "<leader>l", group = "LSP" },
  {
    "<leader>la",
    function()
      -- Names the kinds it wants, so ruff's whole-file actions are listed (configs.lspconfig).
      vim.lsp.buf.code_action { context = { only = { "quickfix", "refactor", "source" } } }
    end,
    desc = "Code actions",
  },
  {
    "<leader>lf",
    function()
      -- Through conform, so a hand-formatted repo is not reformatted (configs.conform).
      require("conform").format { async = true, lsp_format = "fallback" }
    end,
    desc = "Format",
  },
  { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "Info" },
  { "<leader>lr", "<cmd>lsp restart<cr>", desc = "Restart servers" },
  { "<leader>ls", telescope "lsp_dynamic_workspace_symbols", desc = "Workspace symbols" },

  -- t Trouble
  { "<leader>t", group = "Trouble" },
  { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
  { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
  { "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References" },
  { "<leader>tf", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "Definitions" },
  { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
  { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
  { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },

  -- b Buffers
  { "<leader>b", group = "Buffers" },
  {
    "<leader>bb",
    function()
      require("telescope.builtin").buffers(require("telescope.themes").get_dropdown { previewer = false })
    end,
    desc = "Pick buffer",
  },
  { "<leader>bn", "<cmd>enew<cr>", desc = "New buffer" },
  {
    "<leader>bo",
    function()
      Snacks.bufdelete.other()
    end,
    desc = "Close all other buffers",
  },

  -- u UI (the on/off toggles are below, as Snacks toggles that show their state)
  { "<leader>u", group = "UI" },
  {
    "<leader>uh",
    function()
      require("nvchad.themes").open()
    end,
    desc = "Themes",
  },
  {
    "<leader>um",
    function()
      require("menu").open "default"
    end,
    desc = "NvChad menu",
  },

  -- o Open: nvim's own windows
  { "<leader>o", group = "Open" },
  { "<leader>ol", "<cmd>Lazy<cr>", desc = "Lazy" },
  { "<leader>om", "<cmd>Mason<cr>", desc = "Mason" },
  { "<leader>od", "<cmd>Nvdash<cr>", desc = "Dashboard" },
  { "<leader>oc", "<cmd>NvCheatsheet<cr>", desc = "Cheatsheet" },
  { "<leader>oh", "<cmd>checkhealth<cr>", desc = "Checkhealth" },
  {
    "<leader>on",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification history",
  },
  { "<leader>ot", "<cmd>Telescope terms<cr>", desc = "Hidden terminals" },
  { "<leader>ok", "<cmd>WhichKey<cr>", desc = "Every keymap" },
  { "<leader>oa", "<cmd>LlamaStatus<cr>", desc = "AI suggestion server status" },

  -- z Fun
  { "<leader>z", group = "Fun" },
  { "<leader>zl", "<cmd>bufdo bd | Leet<cr>", desc = "Leetcode" },

  -- d Debug (nvim-dap; the Python adapter loads with the first Python buffer)
  { "<leader>d", group = "Debug" },
  { "<leader>dc", dap "continue", desc = "Start / continue" },
  { "<leader>db", dap "toggle_breakpoint", desc = "Toggle breakpoint" },
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input "Break when: ")
    end,
    desc = "Conditional breakpoint",
  },
  { "<leader>dn", dap "step_over", desc = "Step over (next)" },
  { "<leader>di", dap "step_into", desc = "Step into" },
  { "<leader>do", dap "step_out", desc = "Step out" },
  { "<leader>dC", dap "run_to_cursor", desc = "Run to cursor" },
  { "<leader>dl", dap "run_last", desc = "Run the last session again" },
  { "<leader>dr", dap "repl.toggle", desc = "REPL" },
  { "<leader>dx", dap "terminate", desc = "Stop" },
  {
    "<leader>de",
    function()
      require("dapui").eval()
    end,
    desc = "Evaluate under cursor",
    mode = { "n", "x" },
  },
  {
    "<leader>du",
    function()
      require("dapui").toggle()
    end,
    desc = "Debug panels",
  },
  {
    "<leader>dt",
    function()
      require("dap-python").test_method()
    end,
    desc = "Debug the test under the cursor",
  },
}

-- u UI toggles: Snacks toggles, so which-key shows whether each is on
Snacks.toggle.option("number", { name = "Line numbers" }):map "<leader>un"
Snacks.toggle.option("relativenumber", { name = "Relative numbers" }):map "<leader>ur"
Snacks.toggle.option("wrap", { name = "Word wrap" }):map "<leader>uw"
Snacks.toggle
  .new({
    name = "Colour preview",
    get = function()
      return vim.tbl_contains(require("mini.hipatterns").get_enabled_buffers(), vim.api.nvim_get_current_buf())
    end,
    set = function()
      require("mini.hipatterns").toggle(0)
    end,
  })
  :map "<leader>uc"
Snacks.toggle
  .new({
    -- Neovide's own opacity there; otherwise the theme's transparency, for this session
    -- only. NvChad's toggle would rewrite chadrc.lua, so it is not used.
    name = "Transparency",
    get = function()
      if vim.g.neovide then
        return vim.g.neovide_opacity < 1
      end
      return require("nvconfig").base46.transparency
    end,
    set = function(on)
      if vim.g.neovide then
        vim.g.neovide_opacity = on and 0.75 or 1
        return
      end
      require("nvconfig").base46.transparency = on
      require("base46").load_all_highlights()
    end,
  })
  :map "<leader>ut"
Snacks.toggle.inlay_hints({ name = "Inlay hints" }):map "<leader>lh"
Snacks.toggle
  .new({
    -- The local model's inline suggestions (llama.vim). Accept/dismiss keys are in blink.
    name = "AI suggestions",
    get = function()
      return require("configs.llama").enabled()
    end,
    set = function()
      require("lazy").load { plugins = { "llama.vim" } }
      require("configs.llama").toggle()
    end,
  })
  :map "<leader>ua"

-- Outside <leader>
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "Copy the whole file" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer" })
map("n", "<F2>", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { expr = true, desc = "Rename" })

-- Windows: hjkl and their arrow twins (<C-S-…>, so <C-Left>/<C-Right> keep word jumps)
for keys, dir in pairs { h = "h", j = "j", k = "k", l = "l", Left = "h", Down = "j", Up = "k", Right = "l" } do
  local lhs = #keys == 1 and ("<C-" .. keys .. ">") or ("<C-S-" .. keys .. ">")
  map("n", lhs, "<C-w>" .. dir, { desc = "Window " .. ({ h = "left", j = "down", k = "up", l = "right" })[dir] })
end

-- Buffers
map("n", "<Tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Next buffer" })
map("n", "<S-Tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Previous buffer" })

-- Terminals
map({ "n", "t" }, "<M-h>", term { pos = "sp", id = "htoggleTerm" }, { desc = "Horizontal terminal" })
map({ "n", "t" }, "<M-v>", term { pos = "vsp", id = "vtoggleTerm" }, { desc = "Vertical terminal" })
map({ "n", "t" }, "<M-i>", term { pos = "float", id = "floatTerm" }, { desc = "Floating terminal" })
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

-- Insert-mode movement (plain arrows already move the cursor, so no twins)
map("i", "<C-b>", "<Esc>^i", { desc = "Start of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-h>", "<Left>", { desc = "Left" })
map("i", "<C-j>", "<Down>", { desc = "Down" })
map("i", "<C-k>", "<Up>", { desc = "Up" })
map("i", "<C-l>", "<Right>", { desc = "Right" })
