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

      opts.linters = opts.linters or {}
      opts.linters.ruff = {
        -- avoid stdin so we can pass file paths (needed to suppress some rules)
        stdin = false,
        args = {
          "--quiet",
          "--ignore",
          "F403,F405",
        },
      }
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
--
--   -- Setup for LSP servers
--   {
--     "neovim/nvim-lspconfig",
--     opts = function(_, opts)
--       opts.servers = opts.servers or {}
--
--       -- Enable Pyright or basedpyright (choose one)
--       opts.servers.pyright = opts.servers.pyright
--         or {
--           settings = {
--             python = {
--               analysis = {
--                 diagnosticSeverityOverrides = {
--                   reportWildcardImportFromLibrary = "none",
--                   reportWildcardImport = "none",
--                 },
--               },
--             },
--           },
--         }
--     end,
--     --   opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
--     --     settings = {
--     --       python = {
--     --         analysis = {
--     --           diagnosticSeverityOverrides = {
--     --             reportWildcardImportFromLibrary = "none",
--     --             reportWildcardImport = "none",
--     --           },
--     --         },
--     --       },
--     --     },
--     --   })
--     -- end,
--   },
--
--   -- Ruff for Linting via nvim-lint
--   -- {
--   --   "mfussenegger/nvim-lint",
--   --   opts = function(_, opts)
--   --     opts.linters_by_ft = opts.linters_by_ft or {}
--   --     opts.linters_by_ft.python = { "ruff" }
--   --
--   --     opts.linters = opts.linters or {}
--   --     opts.linters.ruff = {
--   --       -- args = { "--quiet", "--ignore", "F403,F405", "-" },
--   --       -- stdin = false,
--   --       command = "ruff",
--   --       args = { "--ignore", "F403,F405" },
--   --       ignore_exitcode = true,
--   --     }
--   --   end,
--   -- },
--
--   -- Ruff for Formatting via conform.nvim
--   {
--     "stevearc/conform.nvim",
--     opts = {
--       formatters_by_ft = {
--         python = { "ruff_format" },
--       },
--     },
--   },
--
--   -- Neotest for Python
--   {
--     "nvim-neotest/neotest-python",
--   },
--
--   -- DAP (Debug Adapter Protocol) setup for Python
--   {
--     "mfussenegger/nvim-dap-python",
--     ft = "python",
--     config = function()
--       local path
--       if vim.fn.has("win32") == 1 then
--         path = require("lazyvim.util").get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
--       else
--         path = require("lazyvim.util").get_pkg_path("debugpy", "/venv/bin/python")
--       end
--       require("dap-python").setup(path)
--     end,
--     keys = {
--       {
--         "<leader>dPt",
--         function()
--           require("dap-python").test_method()
--         end,
--         desc = "Debug Method",
--       },
--       {
--         "<leader>dPc",
--         function()
--           require("dap-python").test_class()
--         end,
--         desc = "Debug Class",
--       },
--     },
--   },
-- }

-- return {
--   -- extend treesitter for python-related filetypes
--   -- setup for lsp servers
--   {
--     "neovim/nvim-lspconfig",
--     opts = function(_, opts)
--       opts.servers = opts.servers or {}
--
--       -- enable pyright or basedpyright (choose one)
--       opts.servers.pyright = opts.servers.pyright
--         or {
--           settings = {
--             python = {
--               analysis = {
--                 diagnosticseverityoverrides = {
--                   reportwildcardimportfromlibrary = "none",
--                 },
--               },
--             },
--           },
--         }
--       -- opts.servers.basedpyright = opts.servers.basedpyright or {}
--
--       -- ruff_lsp setup
--       opts.servers.ruff_lsp = {
--         cmd_env = { ruff_trace = "messages" },
--         init_options = {
--           settings = {
--             loglevel = "error",
--           },
--         },
--         keys = {
--           {
--             "<leader>co",
--             function()
--               require("lazyvim.util").lsp.on_attach(function(client, _)
--                 client.server_capabilities.hoverprovider = false
--               end, "ruff_lsp")
--               require("lazyvim.util").lsp.action["source.organizeimports"]()
--             end,
--             desc = "organize imports",
--           },
--         },
--         settings = {
--           args = { "--ignore", "f403,f405" },
--         },
--       }
--     end,
--   },
--
-- }
--
