return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = { enabled = false },
        nixd = { mason = false },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(t)
        return t ~= "nixfmt" and t ~= "nil" and t ~= "statix"
      end, opts.ensure_installed or {})
    end,
  },
}
