# Unified Color Token System

All colors use a unified semantic token system. This means you only need to change colors in ONE place (`config/colors.sh`) and all tools will automatically use the new colors.

## How It Works

1. **`config/colors.sh`** - Defines the color palette and semantic token mappings
2. **Theme files are auto-generated** for each tool:
   - `config/kitty/theme.conf` - Terminal colors
   - `config/sketchybar/theme/colors` - Status bar colors  
   - `config/nvim/lua/config/theme.lua` - Neovim colors
3. **All configs use semantic tokens** - No hardcoded colors anywhere!

## Semantic Tokens

These are the ONLY tokens you should use in configs:

- **`BACKGROUND`** / **`TOKEN_BACKGROUND`** - Main background (used by terminal, sketchybar)
- **`PRIMARY`** / **`TOKEN_PRIMARY`** - Primary accent (active/focused items, borders)
- **`SECONDARY`** / **`TOKEN_SECONDARY`** - Secondary accent (inactive items, cursor)
- **`TEXT`** / **`TOKEN_TEXT`** - Main text color
- **`TEXT_DIM`** / **`TOKEN_TEXT_DIM`** - Dimmed text
- **`BORDER`** / **`TOKEN_BORDER`** - Border color (used by terminal, borders, sketchybar)
- **`BORDER_INACTIVE`** / **`TOKEN_BORDER_INACTIVE`** - Inactive border

## Changing Themes

To switch themes, simply update the semantic token mappings in `config/colors.sh`:

```bash
# Change these lines in colors.sh to switch themes
export TOKEN_BACKGROUND="$THEME_BG"      # Change which color = background
export TOKEN_PRIMARY="$THEME_PURPLE"     # Change which color = primary
export TOKEN_SECONDARY="$THEME_CYAN"     # Change which color = secondary
export TOKEN_BORDER="$THEME_PURPLE"      # Change which color = border
```

Then run `make bootstrap` to regenerate all theme files. All tools will automatically use the new colors!

## Theme Files

All theme files are auto-generated - **DO NOT EDIT THEM MANUALLY**. They are regenerated during bootstrap:
- `config/kitty/theme.conf` - Included by `kitty.conf`
- `config/sketchybar/theme/colors` - Sourced by `sketchybarrc` and plugins
- `config/nvim/lua/config/theme.lua` - Required by `colorscheme.lua`
