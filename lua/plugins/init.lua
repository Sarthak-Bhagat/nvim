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
      "rcarriga/nvim-notify",
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
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
      table.insert(opts.sources, {
        name = "supermaven",
        group_index = 1,
      })
    end,
  },
  {
    "lambdalisue/vim-suda",
    event = "VeryLazy",
    config = function()
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
  {

    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { ",", "<cmd>VenvSelect<cr>" },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "configs.webdevicons"
    end,
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    enabled = true,
    lazy = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "live_grep_args"
    end,
  },

  {
    "echasnovski/mini.icons",
    config = function()
      require("mini.icons").setup { defaults = true }
    end,
  },

  {
    "echasnovski/mini.animate",
    lazy = "VeryLazy",
    event = "BufRead",
    config = function()
      require("mini.animate").setup()
    end,
  },

  -- {
  --   "mfussenegger/nvim-lint",
  --   lazy = "VeryLazy",
  --   config = function()
  --     require "configs.nvim-lint"
  --   end,
  -- },

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
      },
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

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.mason"
      require "configs.lspconfig"
    end,
    dependencies = {
      "mfussenegger/nvim-lint",
      "rshkarin/mason-nvim-lint",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
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
    "3rd/image.nvim",
    opts = {},
  },
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          names = false, -- Disable color names like "red"
          rgb_fn = true, -- Enable parsing `rgb(...)` and `rgba(...)`
          tailwind = false,
          mode = "foreground", -- Set to "background" if you prefer
          RRGGBBAA = true,
          AARRGGBB = true,
        },
      }
    end,
  },
}
