# nvim-laravel

A Neovim plugin for navigating to Laravel Blade views quickly.

## Features

- Dynamically detects the Laravel project root.
- Opens the corresponding Blade view, component or asset based on the path under the cursor.

## Future Features
- access config values under the cursor
- add auto-complete for model feilds 

## Installation

### Using `lazy.nvim`

Add the following to your plugin configuration:

```lua
{
  "yahyasghayron/nvim-goto-view-laravel",
  main = "goto_view_laravel",
  opts = {}
}
