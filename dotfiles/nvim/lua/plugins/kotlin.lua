vim.lsp.config('kmp-lsp', {
  cmd = { 'kmp-lsp' },
  filetype = { 'kotlin', 'java' },
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'build.gradle',
    'build.gradle.kts',
    '.git',
  },
})
vim.lsp.enable('kmp-lsp')

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { kotlin = { "ktrs" } },
      formatters = {
        ktrs = {
          command = "ktrs",
          args = { "fmt", "--editorconfig", "--stdin-name", "$FILENAME", "-" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { kotlin = { "ktlint" } } },
  },
}
