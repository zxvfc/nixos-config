-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false
vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["docker-bake.hcl"] = "hcl.docker-bake",
    ["docker-bake.override.hcl"] = "hcl.docker-bake",
  },
  pattern = {
    -- e.g. docker-compose.dev.yml, compose.prod.yaml
    ["docker%-compose%..+%.ya?ml"] = "yaml.docker-compose",
    ["compose%..+%.ya?ml"] = "yaml.docker-compose",
  },
})
