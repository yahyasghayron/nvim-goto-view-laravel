local M = {}

-- Load commands and utilities
local commands = require("nvim_laravel.commands")
local utils = require("nvim_laravel.utils")

-- Default configuration
local default_config = {
  keybindings = {
    open_blade_view = "<leader>gv",
    open_asset_file = "<leader>ga",
    open_config_value = "<leader>oc",
  }
}

local user_config = {}

-- Function to merge user config with default config
local function merge_configs(user_cfg, default_cfg)
  for k, v in pairs(default_cfg) do
    if type(v) == "table" and type(user_cfg[k]) == "table" then
      merge_configs(user_cfg[k], v)
    else
      user_cfg[k] = user_cfg[k] or v
    end
  end
  return user_cfg
end

M.setup = function(config)
  user_config = merge_configs(config or {}, default_config)

  -- Set up keybindings
  vim.api.nvim_set_keymap(
    "n",
    user_config.keybindings.open_blade_view,
    ":lua require('nvim_laravel.commands').open_blade_view()<CR>",
    { noremap = true, silent = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    user_config.keybindings.open_asset_file,
    ":lua require('nvim_laravel.commands').open_asset_file()<CR>",
    { noremap = true, silent = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    user_config.keybindings.open_config_value,
    ":lua require('nvim_laravel.commands').open_config_value()<CR>",
    { noremap = true, silent = true }
  )
end

return M
