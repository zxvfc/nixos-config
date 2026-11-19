return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = { enabled = false },
      basedpyright = { enabled = true, mason = false },
      ruff = { mason = false },
    },
  },
}
