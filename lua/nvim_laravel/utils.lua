local M = {}

-- Function to find the project root
function M.find_project_root()
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

return M