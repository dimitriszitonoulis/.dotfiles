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

      local venvBasePath = vim.fn.expand("~/Documents/venvs")
      -- Optional: map project folder name → venv name
      local venv_map = {
        -- ["flask-compose"] = "flask_compose_env",
      }
      local python_bin = (vim.fn.has("win32") == 1) and "\\Scripts\\python.exe" or "/bin/python"
      local last_venv = nil -- Tracks last activated venv

      ----------------------------------------------------------------------
      -- HELPERS
      ----------------------------------------------------------------------

      -- Takes the last directory name from path and checks if there is a venv with the same name in the venvs folder
      -- Continues until it finds a venv or until the whole path is traversed
      local function find_project_for_path(path)
        if not path or path == "" then
          return nil
        end
        local cur = vim.fs.dirname(path)
        while cur and cur ~= "" do
          local name = vim.fn.fnamemodify(cur, ":t")
          local mapped = venv_map[name] or name
          if vim.fn.isdirectory(venvBasePath .. "/" .. mapped) == 1 then
            return mapped
          end
          cur = vim.fs.dirname(cur)
        end
        return nil
      end

      local function set_pyright_venv(config, project)
        local py = venvBasePath .. "/" .. project .. python_bin
        if vim.fn.filereadable(py) == 1 then
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}
          config.settings.python.pythonPath = py
          config.settings.python.venvPath = venvBasePath
          config.settings.python.venv = project

          vim.schedule(function()
            vim.notify("[pyright] Using venv: " .. project .. "\n" .. py, vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("[pyright] Python not found in venv: " .. project, vim.log.levels.WARN)
          end)
        end
      end

      local function setup_dynamic_venv(config, root_dir)
        -- get the name of the current buffer
        local bufname = vim.api.nvim_buf_get_name(0)
        -- find the project file starting from the buffer's path (the 1st buffer that was opened)
        -- if nothing is found try the root directory
        -- could also try to check for all open buffers but that would add overhead
        local project = find_project_for_path(bufname) or find_project_for_path(root_dir)
        if project then
          set_pyright_venv(config, project)
        else
          vim.schedule(function()
            vim.notify("[pyright] No matching venv found for root: " .. root_dir, vim.log.levels.WARN)
          end)
        end
      end

      ----------------------------------------------------------------------
      -- PYRIGHT CONFIG
      ----------------------------------------------------------------------
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        on_new_config = function(config, root_dir)
          setup_dynamic_venv(config, root_dir)
        end,
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

      ----------------------------------------------------------------------
      -- AUTO-RELOAD ON BUFFER SWITCH (OPTIMIZED)
      ----------------------------------------------------------------------
      local function reload_pyright_for_buf(buf)
        if vim.api.nvim_buf_is_loaded(buf) then
          local fname = vim.api.nvim_buf_get_name(buf)
          if fname:match("%.py$") then
            local client = vim.lsp.get_active_clients({ name = "pyright" })[1]
            if client then
              local project = find_project_for_path(fname)
              if project and project ~= last_venv then
                last_venv = project
                set_pyright_venv(client.config, project)
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
            end
          end
        end
      end

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
          reload_pyright_for_buf(args.buf)
        end,
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
  -- There formatting and linting rules can be specified for all projects
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
