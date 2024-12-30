local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end
function _LAZYGIT_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  lazygit:toggle()
end

local setup = {
  icons = {
    breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
    separator = "󰁕", -- symbol used between a key and it's label
    group = "󱢓 ", -- symbol prepended to a group
  },

  -- popup_mappings = {
  --   scroll_down = "<c-d>", -- binding to scroll down inside the popup
  --   scroll_up = "<c-u>", -- binding to scroll up inside the popup
  -- },

  -- window = {
  --   -- border = "none", -- none/single/double/shadow
  --   border = "rounded", -- none, single, double, shadow
  --   -- border = "none", -- none, single, double, shadow
  --   position = "bottom", -- bottom, top
  --   margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  --   padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  --   winblend = 0,
  -- },

  layout = {
    spacing = 6, -- spacing between columns
  },

  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

  -- triggers_blacklist = {
  -- list of mode / prefixes that should never be hooked by WhichKey
  --     i = { "j", "k" },
  --     v = { "j", "k" },
  -- },
}
local mappings = {
  { "<leader>a", "<cmd>Nvdash<cr>", desc = "Dashboard" },
  {
    "<leader>b",
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    desc = "Buffers",
  },
  { "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Explorer" },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
  { "<leader>q", "<cmd>q!<CR>", desc = "Quit" },
  { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit" },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
  { "<leader>l", group = "LSP" },
  { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info" },
  { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
  { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
  { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
  { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>s", group = "Search" },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>r", group = "Run" },
  {
    "<leader>rs",
    '<cmd>autocmd bufwritepost [^_]*.sass,[^_]*.scss  silent exec "!sass %:p %:r.css"<CR>',
    desc = "Auto Compile Sass",
  },
  { "<leader>rr", "<cmd>RunCode<CR>", desc = "Run Code" },
  { "<leader>rf", "<cmd>RunFile<CR>", desc = "Run File" },
  { "<leader>rp", "<cmd>RunProject<CR>", desc = "Run Project" },
  { "<leader>rg", "<cmd>ToggleTerm size=70 direction=float<cr>clear<cr>gradle run<cr>", desc = "Run Gradle" },
  {
    "<leader>rm",
    "<cmd>ToggleTerm size=70 direction=float<cr>mvn exec:java -Dexec.mainClass=com.pojokcode.App<cr>",
    desc = "Run MVN",
  },
  { "<leader>d", group = "Debug" },
  { "<leader>p", group = "Plugins(Lazy)" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync" },
  { "<leader>pS", "<cmd>Lazy clear<cr>", desc = "Status" },
  { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },
  { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile" },
  { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log" },
  { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug" },
  {
    mode = "v",
    {
      "<leader>/",
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Comment Block",
    },
  },
  { "C-t", "lua require('menu').open('default')", desc = "Open Menu" },
}
which_key.setup(setup)
which_key.add(mappings)
