return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "voldikss/vim-floaterm",
    lazy = false,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter", -- Start with the 'enter' preset
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = {
          enabled = false, -- Disable ghost text
        },
      },
    },
  }, -- {
  --     "hrsh7th/nvim-cmp",
  --     opts = function()
  --       local cmp = require "cmp"
  --       cmp.setup {
  --         preselect = cmp.PreselectMode.None,
  --         mapping = cmp.mapping.preset.insert {
  --           ["<ArrowUp>"] = cmp.mapping.select_prev_item(),
  --           ["ArrowDown>"] = cmp.mapping.select_next_item(),
  --         },
  --       }
  --     end,
  --   },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "clangd",
        "rust",
        "markdown",
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]a"] = "@parameter.inner",
            ["]f"] = "@function.outer",
          },
          goto_previous_start = {
            ["[a"] = "@parameter.inner",
            ["[f"] = "@function.outer",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true, -- optional if you're using lazy.nvim
  },
  {
    "tanvirtin/vgit.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = "VimEnter",
    config = function()
      require("vgit").setup()
    end,
  },
}
