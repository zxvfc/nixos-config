return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        docker_language_server = { mason = false },
        dockerls = { enabled = false },
        docker_compose_language_service = { enabled = false },
      },
    },
  },
}
