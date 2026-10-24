return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local out = vim.fn.system({ "darkman", "get" })
        local light = out:match("light") ~= nil
        vim.o.background = light and "light" or "dark"
        vim.cmd.colorscheme(light and "github_light_high_contrast" or "github_dark_high_contrast")
      end,
    },
  },
}
