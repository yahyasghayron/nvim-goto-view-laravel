local M = {}

-- Function to find the project root
local function find_project_root()
  local markers = { "artisan", "composer.json", "composer.lock" }
  local path = vim.fn.getcwd() -- Start from the current working directory

  -- Traverse upwards to find a marker file
  while path do
    for _, marker in ipairs(markers) do
      local marker_path = path .. "/" .. marker
      if vim.fn.filereadable(marker_path) == 1 then
        return path
      end
    end
    -- Move to the parent directory
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      break -- Stop if we are at the root directory
    end
    path = parent
  end

  return nil -- No root found
end


-- Function to open a Blade view
function M.open_blade_view()
  -- Find the root directory
  local root = find_project_root()
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

-- Set up keybinding for the command
vim.api.nvim_set_keymap(
  "n",
  "<leader>gv",
  ":lua require('goto_view_laravel.commands').open_blade_view()<CR>",
  { noremap = true, silent = true }
)

return M
