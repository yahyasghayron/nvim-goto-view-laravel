local M = {}

local utils = require("nvim_laravel.utils")

-- Function to open a Blade view
function M.open_blade_view()
  -- Find the root directory
  local root = utils.find_project_root()
  if not root then
    print("Project root not found! Ensure you are in a Laravel project.")
    return
  end

  -- Get the full string under the cursor
  local cursor_string = vim.fn.expand("<cWORD>")
  
  -- Extract the Blade view path from `view()` or `@include`
  local blade_view = cursor_string:match("view%s*%(%s*['\"]([^'\"]+)['\"]")
    or cursor_string:match("@include%s*%(%s*['\"]([^'\"]+)['\"]")
  
    if not blade_view then
    print("No valid Blade view reference found under the cursor.")
    return
  end

  -- Replace dots with slashes to form the file path
  local file_path = root .. "/resources/views/" .. blade_view:gsub("%.", "/") .. ".blade.php"

  -- Open the Blade file
  if vim.fn.filereadable(file_path) == 1 then
    vim.cmd("edit " .. file_path)
  else
    print("Blade file not found: " .. file_path)
  end
end

-- Function to open an asset file
function M.open_asset_file()
  -- Find the root directory
  local root = utils.find_project_root()
  if not root then
    print("Project root not found! Ensure you are in a Laravel project.")
    return
  end

  -- Get the full string under the cursor
  local cursor_string = vim.fn.expand("<cWORD>")
  
  -- Extract the asset path
  local asset_path = cursor_string:match("asset%s*%(%s*['\"]([^'\"]+)['\"]")
  if not asset_path then
    print("No valid asset reference found under the cursor.")
    return
  end

  -- Form the file path
  local file_path = root .. "/public/" .. asset_path

  -- Open the asset file
  if vim.fn.filereadable(file_path) == 1 then
    vim.cmd("edit " .. file_path)
  else
    print("Asset file not found: " .. file_path)
  end
end

-- Set up keybindings for commands
vim.api.nvim_set_keymap(
  "n",
  "<leader>gv",
  ":lua require('goto_view_laravel.commands').open_blade_view()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ga",
  ":lua require('goto_view_laravel.commands').open_asset_file()<CR>",
  { noremap = true, silent = true }
)

return M
