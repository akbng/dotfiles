local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
    },
    opts = overrides.telescope,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
      },
    },
    event = "BufEnter",
    opts = overrides.treesitter_textobjects,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/lsp-colors.nvim" },
    cmd = { "TroubleToggle", "TroubleClose" },
  },

  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
      vim.g.codeium_manual = true
    end,
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufEnter",
  },

  {
    "windwp/nvim-ts-autotag",
    event = "BufEnter",
    config = function()
      require("nvim-ts-autotag").setup {
        autotag = {
          enable = true,
        },
      }
    end,
  },

  -- Flutter Specific
  {
    "Nash0x7E2/awesome-flutter-snippets",
    ft = { "dart" },
  },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    ft = { "dart" },
    config = function()
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      require("flutter-tools").setup {
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    end,
  },

  -- beautiful notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require "custom.configs.notify-plugins"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
      -- NOTE: Make sure that ripgrep is installed on the system
    },
    opts = {},
  },

  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "custom.configs.mini-nvim"
    end,
  },

  {
    "barrett-ruth/live-server.nvim",
    opts = {},
    keys = {
      { "<leader>lo", "<cmd> LiveServerStart <cr>", desc = "Start the live server" },
      { "<leader>lx", "<cmd> LiveServerStop <cr>", desc = "Stop the live server" },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost", -- needed for folds to load properly
    config = function()
      require "custom.configs.folding-plugins"
    end,
  },

  {
    "kevinhwang91/nvim-fundo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufEnter",
    init = function()
      vim.o.undofile = true
    end,
    opts = {},
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "laher/neorg-exec",
      "nvim-neorg/neorg-telescope",
      "folke/zen-mode.nvim",
      { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
    },
    cmd = { "Neorg" },
    ft = { "norg" },
    config = function()
      require "custom.configs.neorg-config"
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local home_dir = vim.fn.expand "$HOME"
      require("chatgpt").setup {
        api_key_cmd = "gpg --decrypt " .. home_dir .. "/openai.txt.gpg",
      }
    end,
  },

  {
    "m4xshen/smartcolumn.nvim",
    event = "BufEnter",
    opts = {
      colorcolumn = "100",
      disabled_filetypes = {
        "NvimTree",
        "lazy",
        "mason",
        "help",
        "norg",
        "markdown",
        "text",
        "nvdash",
        "noice",
        "octo",
      },
      custom_colorcolumn = { ruby = "120", java = { "180", "200" } },
      scope = "line",
    },
  },

  {
    "ziontee113/icon-picker.nvim",
    dependencies = "stevearc/dressing.nvim",
    cmd = { "IconPickerNormal", "IconPickerInsert", "IconPickerYank" },
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.8,
        width = 0.85,
        options = { colorcolumn = "0" },
      },
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    opts = {},
  },

  -- TODO: Install and configure dap (Debugger UI)
}

return plugins
