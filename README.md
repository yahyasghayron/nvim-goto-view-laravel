# nvim-goto-view-laravel

A Neovim plugin for navigating to Laravel Blade views quickly.

## Features

- Dynamically detects the Laravel project root.
- Opens the corresponding Blade view based on the word under the cursor.
- Designed for use with LunarVim but works with any Neovim configuration.

## Installation

### Using `lazy.nvim`

Add the following to your plugin configuration:

```lua
{
  "yahyasghayron/nvim-goto-view-laravel",
  config = function()
    require("goto_view_laravel").setup()
  end,
}
