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
    lazy = true,
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
  --   },c
  --
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
    lazy = true,
    -- Lazy loading on 'VimEnter' event is necessary.
    event = "VimEnter",
    config = function()
      require("vgit").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Insert VGit into section 'x' (you can choose 'b', 'y', etc.)
      table.insert(opts.sections.lualine_x, {
        function()
          return vim.b.vgit_status or ""
        end,
        cond = function()
          return vim.b.vgit_status ~= nil
        end,
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
  -- ,
  -- {
  --   "folke/noice.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   config = function()
  --     require("noice").setup {
  --       lsp = {
  --         progress = { enabled = false },
  --         message = { enabled = true },
  --         signature = { enabled = true },
  --         hover = { enabled = true },
  --       },
  --       messages = {
  --         enabled = true,
  --         view = "mini", -- minimal popup for messages like :write or :noh
  --         view_error = "notify",
  --         view_warn = "notify",
  --         view_history = "messages",
  --         view_search = false,
  --       },
  --       notify = {
  --         enabled = true,
  --         view = "notify",
  --       },
  --       routes = {
  --         -- Hide annoying messages
  --         {
  --           filter = {
  --             event = "msg_show",
  --             kind = "",
  --             find = "written",
  --           },
  --           opts = { skip = false },
  --         },
  --         {
  --           filter = {
  --             event = "msg_show",
  --             kind = "search_count",
  --           },
  --           opts = { skip = false },
  --         },
  --         {
  --           filter = {
  --             event = "msg_showmode",
  --           },
  --           opts = { skip = false },
  --         },
  --       },
  --       presets = {
  --         bottom_search = false,
  --         command_palette = true,
  --         long_message_to_split = true,
  --         lsp_doc_border = true,
  --       },
  --     }
  --
  --     -- Route vim.notify through nvim-notify
  --     vim.notify = require "notify"
  --   end,
  -- },
}
