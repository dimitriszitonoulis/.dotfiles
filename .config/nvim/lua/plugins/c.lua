return {

  -- Clangd by deafault autoformats code bye deafault
  -- The solution is found in this discussion: 
  -- https://github.com/LazyVim/LazyVim/discussions/122
  --
  -- Unfortunately formatting setup is not exposed by clangd lsp.
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
  --
  -- Although clang-format is not installed via mason, it is in fact embedded into clangd.
  -- https://clangd.llvm.org/features#formatting
  --
  -- The only way to disable it, from the digging I have done, is to add .clang-format files to an existing codebase.
  -- Not ideal, however is this in the only lsp that presents this problem,
  -- I guess it doesn't warrant adding a configurable control of autoformat based on file type or lsp server.
  -- https://github.com/clangd/clangd/issues/702
  --
  --
  -- In order to actually disable autoformatting the following must be added to .config/nvim/lua/config/autocmds.lua
  -- Disable autoformat for lua files
  -- vim.api.nvim_create_autocmd({ "FileType" }, {
  --   pattern = { 
  --      "c",
  --      "cpp",
  --      "h",
  --      "hpp"
  --   },
  --   callback = function()
  --     vim.b.autoformat = false
  --   end,
  -- })
  --
  -- An alternative is to add a .clang-file per project that specifies to not autoformat
  --
  -- Some of the options to turn of autoformatting even though are kept in this file
  -- (even though they do not work) as refferences


  -- Disable auto formating for C, C++
  {
    "LazyVim/LazyVim",
    opts = {
      disabled = { "c", "cpp" },
      format = {},
    },
  },

  -- LSP support via clangd
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },

  -- Formatter setup
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        h = {},
        hpp = {},
      },
      format_on_save = false,
    },
  },

  -- Linter integration
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        c = { "clangtidy" },
        cpp = { "clangtidy" },
      },
    },
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end,
  },

  -- Debugging with nvim-dap and lldb
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = { "codelldb" },
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode", -- or codelldb
        name = "lldb",
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
