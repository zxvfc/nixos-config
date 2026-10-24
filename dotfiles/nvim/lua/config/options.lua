-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

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

vim.opt.relativenumbers = false
