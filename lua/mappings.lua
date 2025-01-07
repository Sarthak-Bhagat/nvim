require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

function _LAZYGIT_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  lazygit:toggle()
end

-- General Mappings
map("n", "<leader>a", "<cmd>Nvdash<cr>", { desc = "Dashboard" })
map(
  "n",
  "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  { desc = "Buffers" }
)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer" })
map("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
-- map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Git Mappings
-- map("n", "<leader>g", nil, { group = "Git" })
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
map("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { desc = "Next Hunk" })
map("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { desc = "Prev Hunk" })
map("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = "Blame" })
map("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = "Preview Hunk" })
map("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = "Reset Hunk" })
map("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = "Reset Buffer" })
map("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = "Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })
map("n", "<leader>go", "<cmd>Telescope git_status<cr>", { desc = "Open changed file" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Checkout commit" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Diff" })

-- LSP Mappings
-- map("n", "<leader>l", nil, { group = "LSP" })
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
map("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
map("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("n", "<leader>lI", "<cmd>Mason<cr>", { desc = "Installer Info" })
map("n", "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
map("n", "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", { desc = "Prev Diagnostic" })
map("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "CodeLens Action" })
map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Quickfix" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })

-- Search Mappings
-- map("n", "<leader>s", nil, { group = "Search" })
map("n", "<leader>sb", "<cmd>Telescope git_branches<cr>", { desc = "Checkout branch" })
map("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
map("n", "<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
-- map("n", "<leader>ss", "<cmd>IncRename<cr>", { desc = "Rename" })
map("n", "<F2>", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })

-- Run Mappings
-- map("n", "<leader>r", nil, { group = "Run" })
map(
  "n",
  "<leader>rs",
  '<cmd>autocmd bufwritepost [^_]*.sass,[^_]*.scss  silent exec "!sass %:p %:r.css"<CR>',
  { desc = "Auto Compile Sass" }
)
map("n", "<leader>rr", "<cmd>RunCode<CR>", { desc = "Run Code" })
map("n", "<leader>rf", "<cmd>RunFile<CR>", { desc = "Run File" })
map("n", "<leader>rp", "<cmd>RunProject<CR>", { desc = "Run Project" })
map("n", "<leader>rg", "<cmd>ToggleTerm size=70 direction=float<cr>clear<cr>gradle run<cr>", { desc = "Run Gradle" })
map(
  "n",
  "<leader>rm",
  "<cmd>ToggleTerm size=70 direction=float<cr>mvn exec:java -Dexec.mainClass=com.pojokcode.App<cr>",
  { desc = "Run MVN" }
)

-- Plugins Mappings
-- map("n", "<leader>p", nil, { group = "Plugins(Lazy)" })
map("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Install" })
map("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync" })
map("n", "<leader>pS", "<cmd>Lazy clear<cr>", { desc = "Status" })
map("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Clean" })
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Update" })
map("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
map("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Log" })
map("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Debug" })

-- Debug Mappings
-- map("n", "<leader>d", nil, { group = "Debug" })
map(
  "n",
  "<leader>dt",
  ":lua vim.g.neovide_transparency = (vim.g.neovide_transparency == 0.75 and 1 or 0.75)<CR>",
  { desc = "Toggle transparency" }
)
map("n", "<leader>da", ":lua require('menu').open('default')<cr>", { desc = "Open Menu" })

-- Visual Mode Comment Block
map(
  "v",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Comment Block" }
)

-- Menu
