return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = { mason = false },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gdscript", "godot_resources", "gdshader" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatter_by_ft = {
        gdscript = { "gdformat" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.gdscript = { "gdlint" }

      opts.linters = opts.linters or {}
      opts.linters.gdlint = {
        cmd = "gdlint",
        stdin = false,
        append_fname = true,
        ignore_exitcode = true, -- gdlint exits non-zero when it finds problems
        stream = "both",
        parser = require("lint.parser").from_pattern(
          "^[^:]+:(%d+): (%a+): (.+) %(([%w%-]+)%)$",
          { "lnum", "severity", "message", "code" },
          { Error = vim.diagnostic.severity.WARN },
          { source = "gdlint" }
        ),
      }
    end,
  },
}
