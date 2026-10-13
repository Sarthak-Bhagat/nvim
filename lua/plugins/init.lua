return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "smjonas/inc-rename.nvim",
    event = "VeryLazy",
    config = function()
      require("inc_rename").setup {}
    end,
  },

  {
    "folke/noice.nvim",
    enabled = true,
    lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = { "BufRead", "BufnewFile", "BufReadPre" },
    opts = {
      messages = { enabled = true },
      notify = { enabled = true },
      lsp = {
        progress = { enabled = true },
        hover = { enabled = false },
        signature = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        -- bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    },
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "LspAttach",
    opts = {
      keymaps = {
        accept_suggestion = "<A-S-e>",
        clear_suggestion = "<C-x>",
        accept_word = "<C-y>",
      },
      disable_keymaps = false,
      log_level = "info",
      dsable_inline_completion = false,
    },
  },

  -- Completion: blink.cmp through NvChad's own spec, which also disables nvim-cmp.
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- lazydev's completions for Neovim's Lua API, ahead of the LSP's, in Lua files only.
      opts.sources.per_filetype = { lua = { inherit_defaults = true, "lazydev" } }
      opts.sources.providers = vim.tbl_extend("force", opts.sources.providers or {}, {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      })
      -- <C-y> is Supermaven's accept-word; <CR> already accepts the highlighted item.
      opts.keymap["<C-y>"] = false
      return opts
    end,
  },
  -- Smart edit: a file he cannot write opens through sudo, so :w asks for the password.
  -- The flag must be set before plugin/suda.vim is sourced (init, not config), and the
  -- plugin must load before the first file is read (not VeryLazy). Both were wrong, so
  -- smart edit never armed.
  {
    "lambdalisue/vim-suda",
    lazy = false,
    init = function()
      vim.g.suda_smart_edit = 1
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  -- snacks.nvim, only these modules (#51). toggle and bufdelete are libraries the keymaps
  -- call as Snacks.toggle and Snacks.bufdelete; they need no setup here.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true }, -- heavy features off on huge files
      quickfile = { enabled = true }, -- draw the file before plugins finish loading
      indent = { enabled = true }, -- guides and scope; replaces indent-blankline and mini.indentscope
      words = { enabled = true }, -- highlight the symbol's other uses; ]] and [[ jump between them
      notifier = { enabled = true }, -- noice draws notifications through it; replaces nvim-notify
    },
  },

  -- NvChad's indent guides; snacks' indent replaces them.
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function(_, opts)
      return require "configs.webdevicons"(opts)
    end,
  },

  -- Telescope's extensions load with Telescope itself. live_grep_args had its own spec
  -- with `lazy = "VeryLazy"` and no trigger, so it never loaded; NvChad's
  -- extensions_list is not read by anything any more.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      for _, ext in ipairs { "fzf", "live_grep_args" } do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    "nvim-mini/mini.icons",
    config = function()
      require("mini.icons").setup { defaults = true }
    end,
  },

  {
    "nvim-mini/mini.hipatterns",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require "configs.hipatterns"
    end,
  },

  {
    "nvim-mini/mini.animate",
    lazy = "VeryLazy",
    event = "BufRead",
    config = function()
      require("mini.animate").setup()
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      require "configs.nvim-lint"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = "VeryLazy",
    requires = { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "java",
        "kotlin",
        "rust",
        -- urd and scrobd: python, Jinja templates, schema.sql, Dockerfile, pyproject
        "python",
        "html",
        "htmldjango",
        "jinja",
        "jinja_inline",
        "sql",
        "dockerfile",
        "toml",
        "fish",
        -- noice highlights the command line with these
        "regex",
        "bash",
      },
      -- Ignored since nvim-treesitter moved to its main branch: a parser not listed
      -- above is not installed on demand. Add it here and run :TSInstallAll.
      auto_install = true,
    },
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = "VeryLazy",
    event = "BufRead",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require "configs.dapui"
    end,
  },

  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    opts = {
      -- main_image = "logo",
      main_image = "language",
      logo = "https://0x0.st/H3Rh.png",
      show_time = true,
      log_level = nil,
      workspace_text = "📁 %s",
      -- workspace_text = function(project_name, filename)
      --   local name_only = filename:match "[^/\\]+$" or filename
      --   local display = project_name or name_only
      --
      --   local prefix = "editing "
      --   local prefix_len = 7 -- Length of "editing "
      --
      --   if prefix_len + #display + #name_only <= 25 then
      --     return prefix .. display .. " " .. name_only
      --   end
      --
      --   return prefix .. display
      -- end,
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = require("configs.ufo").opts,
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = require("configs.ufo").config,
  },

  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup {}
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = require "configs.whichkey",
  },

  {
    "akinsho/toggleterm.nvim",
    lazy = "VeryLazy",
    cmd = "ToggleTerm",
    config = function()
      require "configs.toggleterm"
    end,
  },

  -- The maintained fork: the original (ahmedkhalf, untouched since 2024) calls
  -- vim.lsp.buf_get_clients(), which nvim 0.12 removed. The module is `project` now.
  {
    "DrKJeff16/project.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.project"
    end,
    config = function(_, opts)
      require("project").setup(opts)
      -- The picker lists history plus this session's projects, so a main project not
      -- visited lately would be missing. Add any that are to this session's list; the
      -- plugin saves the session into history on exit like any visited project.
      local session = require("project.util").history.get_session_projects()
      for _, p in ipairs(opts.custom_projects) do
        local listed = vim.tbl_contains(session, function(v)
          return v.path == p.path
        end, { predicate = true })
        if not listed then
          table.insert(session, { path = p.path, name = p.name })
        end
      end
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.mason"
      require "configs.lspconfig"
    end,
    dependencies = {
      "mfussenegger/nvim-lint",
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
    options = {
      show_source = true,
    },
  },

  -- {
  --   "kiyoon/jupynium.nvim",
  --   ft = "python",
  --   build = "pip3 install --user .",
  --   -- build = "conda run --no-capture-output -n jupynium pip install .",
  --   -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  --   dependencies = {
  --     "rcarriga/nvim-notify", -- optional
  --     "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
  --   },
  -- },

  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },

  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    lang = "python3",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    -- plugins = {
    --   non_standalone = true,
    -- },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
    },
  },
}
