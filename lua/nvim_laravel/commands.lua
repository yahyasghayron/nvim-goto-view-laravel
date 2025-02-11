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
    or cursor_string:match("markdown%s*%(%s*['\"]([^'\"]+)['\"]")
  
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

function M.open_config_value()
  -- Find the root directory
  local root = utils.find_project_root()
  if not root then
    print("Project root not found! Ensure you are in a Laravel project.")
    return
  end

  -- Get the full string under the cursor
  local cursor_string = vim.fn.expand("<cWORD>")
  
  -- Extract the config path
  local config_path = cursor_string:match("config%s*%(%s*['\"]([^'\"]+)['\"]")
  if not config_path then
    print("No valid config reference found under the cursor.")
    return
  end

  -- Split the config path into file and key
  local parts = {}
  for part in config_path:gmatch("[^%.]+") do
    table.insert(parts, part)
  end

  if #parts == 0 then
    print("Invalid config path.")
    return
  end

  -- Construct the config file path
  local config_file = root .. "/config/" .. parts[1] .. ".php"

  -- Open the config file
  if vim.fn.filereadable(config_file) == 1 then
    vim.cmd("edit " .. config_file)

    -- If there is a nested key, search for it and place the cursor
    if #parts > 1 then
      local search_key = "['\"]" .. parts[2] .. "['\"]"
      local result = vim.fn.search(search_key, "w")
      if result == 0 then
        print("Key not found: " .. parts[2])
      end
    end
  else
    print("Config file not found: " .. config_file)
  end
end


return M
