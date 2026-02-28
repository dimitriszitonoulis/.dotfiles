return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load immediately
    opts = {
      -- style = "day",
      -- style = "moon",
      -- style = "storm",
      style = "night",
      transparent = false, -- make backround solid
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
    config = function(_, opts)
      require("tokyonight").load(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   -- priority = 1000, -- only needed if laze = true
  --   name = "catppuccin",
  --   flavor = "macchiato",
  --   opts = {
  --     lsp_styles = {
  --       underlines = {
  --         errors = { "undercurl" },
  --         hints = { "undercurl" },
  --         warnings = { "undercurl" },
  --         information = { "undercurl" },
  --       },
  --     },
  --     integrations = {
  --       aerial = true,
  --       alpha = true,
  --       cmp = true,
  --       dashboard = true,
  --       flash = true,
  --       fzf = true,
  --       grug_far = true,
  --       gitsigns = true,
  --       headlines = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       leap = true,
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = true,
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       neotree = true,
  --       noice = true,
  --       notify = true,
  --       snacks = true,
  --       telescope = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  --   specs = {
  --     {
  --       "akinsho/bufferline.nvim",
  --       optional = true,
  --       opts = function(_, opts)
  --         if (vim.g.colors_name or ""):find("catppuccin") then
  --           opts.highlights = require("catppuccin.special.bufferline").get_theme()
  --         end
  --       end,
  --     },
  --   },
  --
  -- config = function(_, opts)
  --   require("catppuccin").setup(opts)
  --   vim.cmd.colorscheme("catppuccin")
  -- end,
  -- },
  -- -- Since I had custom options (like the behaviour of bufferline),
  -- -- I chose to use the config option
  -- -- The following can be used, but I must set lazy = true
  -- -- {
  -- --   "LazyVim/LazyVim",
  -- --   opts = {
  -- --     colorscheme = "catppuccin",
  -- --   }
  -- -- }
}
