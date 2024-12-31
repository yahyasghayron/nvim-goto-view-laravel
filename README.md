# nvim-laravel

A Neovim plugin for navigating to Laravel Blade views quickly.

## Features

- Project-Aware Navigation:

  - Dynamically detects the Laravel project root.
  - Quickly navigate to Blade views, components, and asset files under the cursor.
  - Access configuration values directly under the cursor.

- Enhanced Framework Support (Coming Soon):
  
  - Auto-complete for model fields and relationships.
  - Explore and navigate facade methods and helper functions.
  - Jump to routes, migrations, or controllers with ease.

## Installation

### Using `lazy.nvim`

Add the following to your plugin configuration:

```lua
{
  "yahyasghayron/nvim-laravel",
  opts = {
    keybindings = {
      open_blade_view = "<leader>bb",
      open_asset_file = "<leader>aa",
      open_config_value = "<leader>cc",
    },
  }
}
