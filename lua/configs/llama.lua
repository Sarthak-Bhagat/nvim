-- llama.vim: inline suggestions from the local llama-server (Qwen2.5-Coder 3B).
-- Its own keys are all off: accepting and dismissing live in blink's keymap (configs via
-- plugins/init.lua), where each key acts on a suggestion only when one is showing and
-- otherwise falls through. Instruction editing is off; every <leader>ll default is gone.
local M = {}

M.config = {
  show_info = 0,
  t_max_predict_ms = 500,
  keymap_fim_accept_full = "",
  keymap_fim_accept_word = "",
  keymap_fim_accept_line = "",
  keymap_fim_trigger = "",
  keymap_fim_next = "",
  keymap_fim_prev = "",
  keymap_debug_toggle = "",
  keymap_inst_trigger = "",
  keymap_inst_rerun = "",
  keymap_inst_continue = "",
  keymap_inst_accept = "",
  keymap_inst_cancel = "",
}

local function call(fn, ...)
  local ok, res = pcall(vim.fn["llama#" .. fn], ...)
  return ok and res
end

-- A blink keymap command: "full", "line" or "word" accepts, "hide" dismisses. Returns true
-- (handled) only when a suggestion is showing, so blink moves on to the next command.
function M.action(what)
  return function()
    if not call "is_fim_hint_shown" then
      return false
    end
    -- Blink maps with expr = true, which holds textlock; the edit has to wait until it lifts.
    vim.schedule(function()
      if what == "hide" then
        call "fim_hide"
      else
        call("fim_accept", what)
      end
    end)
    return true
  end
end

-- llama#disable() clears the plugin's autocmd group, so a populated group means enabled.
function M.enabled()
  local ok, cmds = pcall(vim.api.nvim_get_autocmds, { group = "llama" })
  return ok and #cmds > 0
end

function M.toggle()
  call "toggle"
end

return M
