# Keymaps redo — design

Approved section by section, 2026-10-13. Branch `keymaps`, from `main` at `76e9624`;
fast-forward merged into `main` when done, then the branch is deleted.

## Rules

1. **`<leader>` + group letter + key.** Only four commands sit at level one: `/ e v x`. They
   are muscle memory and keep their current meanings.
2. **One file.** `lua/mappings.lua` becomes a single which-key table (`wk.add`): every
   group, key, description and icon, read top to bottom. `lua/configs/whichkey.lua` keeps
   only which-key's setup. NvChad's own map file (`require "nvchad.mappings"`) stops
   loading, so no key exists that this file does not declare.
3. **No key is both a command and a prefix.** Today `<leader>w` (save) shadows
   `<leader>wk`/`wK`, and `<leader>b` is a key and a prefix at once, so which-key waits on both.
4. **Every direction key on `h/j/k/l` gets an arrow twin.** Windows use `<C-S-arrows>`, not
   `<C-arrows>`, because `<C-Left>`/`<C-Right>` keep their word jumps.
5. **LSP leans on nvim's built-ins (option A).** nvim 0.11+ already provides `K`, `grn`,
   `gra`, `grr`, `gri`, `grt`, `gO`, `[d`/`]d`, `<C-w>d`, and `<C-s>` in insert mode.
   `<leader>l` holds only what has no built-in. `F2` (rename with a live preview) and
   `<leader>la` (code actions including ruff's whole-file ones) stay as deliberate extras.

## Level one

| Key | Does |
|---|---|
| `<leader>/` | Toggle comment: the line in normal mode, the selection in visual mode. Uses nvim's built-in `gc`; Comment.nvim, which the old visual map called, is not installed |
| `<leader>e` | Toggle nvim-tree |
| `<leader>v` | New vertical terminal (NvChad term) |
| `<leader>x` | Close the buffer (NvChad tabufline) |

## Groups

| Group | Key | Does |
|---|---|---|
| **f Find** | `ff` | Telescope find_files |
| | `fr` | Recent files in this project (oldfiles, cwd only) |
| | `fo` | Recent files everywhere (oldfiles) |
| | `fa` | All files, including hidden and git-ignored |
| | `fg` | Live grep, with arguments (live_grep_args) |
| | `fw` | Grep the word under the cursor |
| | `fz` | Fuzzy-find in this buffer |
| | `fb` | Buffers |
| | `fh` | Help tags |
| | `fk` | Keymaps |
| | `fc` | Commands |
| | `fm` | Marks |
| | `fR` | Registers |
| | `fM` | Man pages |
| | `fp` | Projects: his main projects plus history (project.nvim's Telescope picker); added 10-13 when project.nvim got its project list |
| **g Git** | `gg` | Lazygit, through lazygit.nvim (`:LazyGit`), not a toggleterm float: his call at review |
| | `gj` / `g<Down>` | Next hunk (gitsigns `nav_hunk("next")`) |
| | `gk` / `g<Up>` | Previous hunk (`nav_hunk("prev")`) |
| | `gp` | Preview hunk |
| | `gs` | Stage or unstage the hunk (gitsigns toggles) |
| | `gr` | Reset hunk |
| | `gR` | Reset buffer |
| | `gl` | Blame line |
| | `gd` | Diff against HEAD |
| | `go` | Changed files (Telescope git_status) |
| | `gb` | Branches |
| | `gc` | Commits |
| **l LSP** | `la` | Code actions, naming every kind, so ruff's whole-file actions are listed |
| | `lf` | Format through conform (obeys the per-repo format rule) |
| | `li` | `:checkhealth vim.lsp` |
| | `lr` | `:lsp restart` |
| | `ls` | Workspace symbols (Telescope, dynamic) |
| | `lh` | Toggle inlay hints |
| **t Trouble** | `tt` | Workspace diagnostics |
| | `td` | Document diagnostics |
| | `tr` | References |
| | `tf` | Definitions |
| | `ts` | Symbols |
| | `tq` | Quickfix list |
| | `tl` | Location list |
| **b Buffers** | `bb` | Pick a buffer (Telescope buffers, dropdown, no preview) |
| | `bn` | New empty buffer |
| | `bo` | Close all other buffers |
| **u UI** | `ut` | Transparency: Neovide's opacity in Neovide; otherwise the theme's transparency, **for the session only**. NvChad's own toggle rewrites `chadrc.lua`, so it is not used; the default stays whatever `chadrc.lua` says |
| | `un` | Toggle line numbers |
| | `ur` | Toggle relative numbers |
| | `uc` | Toggle colour preview in this buffer (mini.hipatterns, below) |
| | `uh` | Theme picker |
| | `uw` | Toggle word wrap |
| | `um` | NvChad menu |
| **o Open** | `ol` | Lazy |
| | `om` | Mason |
| | `od` | Dashboard (Nvdash) |
| | `oc` | NvChad cheatsheet |
| | `oh` | `:checkhealth` |
| | `on` | Notification history (Noice) |
| | `ot` | Hidden-terminal picker (Telescope terms) |
| | `ok` | Every keymap (which-key) |
| **z Fun** | `zl` | Leetcode: closes all buffers, then `:Leet`, as now |
| **d Debug** | — | Reserved. No keys until DAP is set up, which is a separate board task; which-key hides an empty group |

## Outside `<leader>`

NvChad's map file declared these; they are declared again here, with the same behaviour.

| Mode | Keys | Does |
|---|---|---|
| Normal | `<Esc>` | Clear search highlight |
| Normal | `<C-s>` | Save |
| Normal | `<C-c>` | Copy the whole file |
| Normal | `<C-h/j/k/l>`, `<C-S-Left/Down/Up/Right>` | Move between windows |
| Normal | `<Tab>` / `<S-Tab>` | Next / previous buffer |
| Normal, terminal | `<M-h>` / `<M-v>` / `<M-i>` | Toggle horizontal / vertical / floating terminal |
| Terminal | `<C-x>` | Leave terminal mode |
| Insert | `<C-b>` / `<C-e>` | Start / end of line |
| Insert | `<C-h/j/k/l>` | Move the cursor (plain arrows already do this, so no twin) |
| Normal | `F2` | Rename, with a live preview (inc-rename) |
| Insert | `<A-S-e>` / `<C-y>` | Accept the local model's suggestion, whole / one word (llama.vim; Supermaven's keys, added 10-13) |

Unchanged because nothing here declares them: nvim's built-ins (rule 5, plus `gc`), flash's
`s`/`S`/`r`/`R`, surround's `ys`/`ds`/`cs`, and ufo's folds.

**In kitty, `<C-S-arrows>` do not reach nvim.** kitty's default shortcuts take them for tab
switching and scrolling. Accepted: serious work happens in Neovide, where they work. kitty is not
changed.

## Removed

| Gone | Why |
|---|---|
| `<leader>rr` / `rf` / `rp` | `:RunCode` and the rest come from code_runner.nvim, which was never installed; the keys came across in the November 2024 port and have done nothing since |
| `<leader>rg` / `rm` / `rs` | Gradle run, Maven run (hardcoded `com.pojokcode.App`), Sass auto-compile: his call |
| The `s` Search group | Merged into `f` |
| `<leader>sb`, `sr` | Duplicates of `gb` and `fo` |
| `<leader>ld`, `lw`, `lq` | Trouble does these better |
| `<leader>lj` / `lk` | Built-in `[d` / `]d` |
| `<leader>ll` | CodeLens: neither ruff nor ty provides any |
| `<leader>p*` | Eight Lazy subcommands; `ol` opens Lazy, where all of them are |
| `<leader>w`, `h`, `a`, `b`, `n` as single keys | Level one is `/ e v x` only. Save is `<C-s>`, clearing highlight is `<Esc>`, the rest moved into groups |
| NvChad's `<leader>ch`, `cm`, `fm`, `ma`, `pt`, `rn`, `th`, `wK` | Re-homed: `ch`→`oc`, `cm`→`gc`, `fm`→`lf`, `ma`→`fm`, `pt`→`ot`, `rn`→`ur`, `th`→`uh`, `wK`→`ok` |
| NvChad's `<leader>wk`, `wa`/`wr`/`wl`, `D`, `ds`, `h` | Dropped: which-key shows on `<leader>` anyway; workspace folders are rarely wanted by hand; `D` is built in as `grt`; `ds` is Trouble's `td`; `h` (horizontal terminal) is `<M-h>` |

## Changed from the approved design

- `gu` (undo stage) is gone: gitsigns deprecated `undo_stage_hunk`, and `stage_hunk` now
  unstages a staged hunk, so `gs` covers both.

## Also on this branch, separate commits

1. **Colour preview → mini.hipatterns** (`nvim-mini/mini.hipatterns`): hex colours plus his
   `[r, g, b, a]` arrays, live as he edits, toggled per buffer with `uc`. Replaces
   `lua/custom/color_preview.lua`, which was a one-off snapshot with a global flag. It is deleted,
   and git keeps it.
2. **vim-suda fix:** `vim.g.suda_smart_edit = 1` moves to `init`, and the plugin loads before the
   first file is read. Today the flag is set in `config`, after `plugin/suda.vim` has already
   checked it, so smart edit never arms. The result: a file he cannot write reopens through sudo,
   and `:wq` asks for his password.
3. **Dead code out:** the removed keys above, and the `_LAZYGIT_TOGGLE` global, which `gg` no
   longer needs.

## Testing

Headless checks, each shown failing before the change:

- **The map matches this document.** Dump every keymap after startup and compare it with the
  tables above: every key present with its description, no NvChad map left over, and no key that
  is both a command and a prefix.
- **which-key's health check** reports no overlapping keys.
- **suda:** open a root-owned scratch file. Before the fix the buffer is the plain path; after it,
  it is `suda://…`.
- **Colour preview:** a buffer holding `[255, 0, 0, 255]` and `#00ff00` gets highlights for both
  with `uc` on, and none with it off.

Then he uses it for real. Headless cannot show which-key's popup as he will see it.

## Out of scope

- DAP: a board task of its own; `d` is reserved for it.
- kitty's shortcuts.
