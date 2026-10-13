-- His main projects, always offered by the project picker (<leader>fp). The config folders
-- are tracked by yadm from outside, so they have no .git of their own and would otherwise
-- never be detected as projects.
local git = "/mnt/Secondary/Documents/git/"
local config = vim.fn.expand "~/.config/"

return {
  spinner = { enabled = true, kind = "cursor" }, -- spinner.nvim, while it finds a root
  custom_projects = {
    { path = git .. "urd", name = "urd" },
    { path = git .. "scrobd", name = "scrobd" },
    { path = git .. "mediactl", name = "mediactl" },
    { path = git .. "mpv-clipper", name = "mpv-clipper" },
    { path = git .. "dotfiles-public", name = "dotfiles-public" },
    { path = "/mnt/Secondary/Downloads/FF_Downloads/SarthakVault", name = "vault" },
    { path = config .. "nvim", name = "nvim config" },
    { path = config .. "fish", name = "fish config" },
    { path = config .. "mpv", name = "mpv config" },
    { path = config .. "kitty", name = "kitty config" },
  },
}
