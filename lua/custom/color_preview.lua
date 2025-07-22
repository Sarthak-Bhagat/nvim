local M = {}
local ns = vim.api.nvim_create_namespace "color_preview_ns"
local enabled = false

function M.toggle_color_preview()
  local bufnr = vim.api.nvim_get_current_buf()

  if enabled then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    enabled = false
    vim.notify "Color preview disabled"
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for lnum, line in ipairs(lines) do
    local r, g, b = string.match(line, "%[(%d+),%s*(%d+),%s*(%d+),%s*%d+%]")
    if r and g and b then
      -- Convert to numbers
      r, g, b = tonumber(r), tonumber(g), tonumber(b)
      local color = string.format("#%02x%02x%02x", r, g, b)

      -- Set the highlight group dynamically
      local group = "ColorPreview_" .. color:gsub("#", "")
      vim.api.nvim_set_hl(0, group, { bg = color, fg = color })

      -- Add the virtual text
      vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, 0, {
        virt_text = { { " ", group } },
        virt_text_pos = "eol",
      })
    end
  end

  enabled = true
  vim.notify "Color preview enabled"
end

return M
