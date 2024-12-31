-- Automatically load the plugin with default or user-provided configurations
local user_config = vim.g.nvim_laravel_config or {}

require("nvim_laravel").setup(user_config)