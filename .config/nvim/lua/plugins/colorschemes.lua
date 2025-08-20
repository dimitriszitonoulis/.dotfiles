return {
  -- {
  --   "folke/tokyonight.nvim", -- or another colorscheme plugin
  --   lazy = false, -- load immediately
  --   priority = 1000, -- load before other plugins
  --   config = function()
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- }
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- load immediately
  --
  --   config = function()
  --     require("tokyonight").setup({
  --       -- style = "day",
  --       -- style = "moon",
  --       -- style = "storm",
  --       style = "night",
  --       transparent = false, -- make backround solid
  --       styles = {
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --       },
  --     })
  --     vim.cmd([[colorscheme tokyonight]])
  --
  --     --For tokyonight-day
  --     -- Set the cursor color to black (in GUI or terminal that supports it)
  --     vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "black" })
  --   end,
  -- },

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
      vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "black" })
    end,
  },
}
