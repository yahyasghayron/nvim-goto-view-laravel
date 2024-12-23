local M = {}

-- Function to find the project root
local function find_project_root()
  local markers = { "artisan", "composer.json", "composer.lock" }
  local cwd = vim.fn.getcwd()
  for _, marker in ipairs(markers) do
    local path = vim.fn.findfile(marker, cwd .. ";")
    if path ~= "" then
      return vim.fn.fnamemodify(path, ":h")
    end
  end
  return nil
end

-- Function to open a Blade view
function M.open_blade_view()
  -- Find the project root
  local root = find_project_root()
  if not root then
    print("Project root not found! Ensure you are in a Laravel project.")
    return
  end

  -- Get the word under the cursor
  local word = vim.fn.expand("<cword>")
  -- Construct the Blade file path
  local file = root .. "/resources/views/" .. word:gsub("%.", "/") .. ".blade.php"

  -- Open the Blade file
  if vim.fn.filereadable(file) == 1 then
    vim.cmd("edit " .. file)
  else
    print("Blade file not found: " .. file)
  end
end

-- Set up keybinding for the command
vim.api.nvim_set_keymap(
  "n",
  "<leader>ov",
  ":lua require('goto_view_laravel.commands').open_blade_view()<CR>",
  { noremap = true, silent = true }
)

return M
