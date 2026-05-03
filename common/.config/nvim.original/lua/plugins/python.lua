return {

  -- Treesitter for Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "ninja",
        "rst",
      },
    },
  },

  -- LSP config for Pyright
  {
    "neovim/nvim-lspconfig",

    opts = function(_, opts)
      opts.servers = opts.servers or {}

      ----------------------------------------------------------------------
      -- PYRIGHT CONFIG
      ----------------------------------------------------------------------
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportWildcardImportFromLibrary = "none",
                reportWildcardImport = "none",
              },
            },
          },
        },
      })

      -- do not use ruff as lsp
      -- this did nothing:
      -- opts.servers.ruff = false

      -- For some reason ruff (not ruff-lsp) auto attached itself as a lsp
      -- Prevent ruff-lsp from auto-attaching via Mason
      opts.setup = {
        ruff = function()
          return true
        end,
      }
    end,
  },

  -- For formatting use the file .config/ruff/ruff.toml
  -- There, formatting and linting rules can be specified for all projects
  -- If that  file is used , there is no reason to specify args in:
  -- "mfussenegger/nvim-lint",
  --   opts.linters.ruff = {
  --     stdin = false,
  --     args = {
  --       "--quiet",
  --       "--ignore",
  --       "F403,F405",
  --     },
  --
  --  Even though these are not needed they are kept as refferences

  -- Ruff for Linting via nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.python = { "ruff" }

      -- opts.linters = opts.linters or {}
      -- opts.linters.ruff = {
      --   -- avoid stdin so we can pass file paths (needed to suppress some rules)
      --   stdin = false,
      --   args = {
      --     "--quiet",
      --     "--ignore",
      --     "F403,F405",
      --   },
      -- }
    end,
  },

  -- Ruff for Formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- Neotest for Python
  {
    "nvim-neotest/neotest-python",
  },

  -- DAP for Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      local path
      if vim.fn.has("win32") == 1 then
        path = require("lazyvim.util").get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
      else
        path = require("lazyvim.util").get_pkg_path("debugpy", "/venv/bin/python")
      end
      require("dap-python").setup(path)
    end,
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
      },
    },
  },
}
