local M = {}

-- Load commands and utilities
local commands = require("nvim_laravel.commands")
local utils = require("nvim_laravel.utils")

M.setup = function()
  -- Add keybindings or default configurations here
  vim.api.nvim_set_keymap(
    "n",
    "<leader>gv",
    ":lua require('nvim_laravel.commands').open_blade_view()<CR>",
    { noremap = true, silent = true }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>ga",
    ":lua require('nvim_laravel.commands').open_asset_file()<CR>",
    { noremap = true, silent = true }
  )

    -- Add a keybinding for the new functionality
  vim.api.nvim_set_keymap(
    "n",
    "<leader>gc",
    ":lua require('nvim-laravel.commands').open_config_value()<CR>",
    { noremap = true, silent = true }
  )
end

return M