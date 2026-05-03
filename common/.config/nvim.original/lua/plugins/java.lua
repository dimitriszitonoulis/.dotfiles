return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Ensure the nested tables exist
      opts.settings = opts.settings or {}
      opts.settings.java = opts.settings.java or {}
      opts.settings.java.project = opts.settings.java.project or {}

      opts.settings.java.project.referencedLibraries = {
        "/home/dim/jason/jason-interpreter/build/libs/jason-interpreter-3.3.1.jar",
      }
    end,
  },
}
