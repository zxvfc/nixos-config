vim.lsp.config('kmp-lsp', {
  cmd = { 'kmp-lsp' },
  filetypes = { 'kotlin', 'java' },
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
      formatters_by_ft = {
        kotlin = {
          "ktrs",
          "ktrs_lint",
        }
      },
      formatters = {
        ktrs = {
          command = "ktrs",
          args = { "fmt", "--editorconfig", "--stdin-name", "$FILENAME", "-" },
        },
        ktrs_lint = {
          command = "ktrs",
          args = { "lint", "--format", "$FILENAME" },
          stdin = false,
          exit_codes = { 0, 1 },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { kotlin = { "ktlint" } } },
  },
}
