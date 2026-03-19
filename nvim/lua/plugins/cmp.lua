-- lua/plugins/cmp.lua
return {
  {
    "saghen/blink.cmp",
    -- Automatically download pre-built binaries so you don't have to compile Rust
    version = "v1.*", 
    
    dependencies = {
      -- Provides a massive library of standard snippets for all languages
      "rafamadriz/friendly-snippets",
    },

    opts = {
      -- 'default' preset matches standard IDE behavior (Enter to accept, arrow keys to navigate)
      -- You can also use 'super-tab' if you prefer using Tab to accept completions
      keymap = { preset = "default" },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are perfectly aligned in the menu
        nerd_font_variant = "mono",
      },

      -- Tell blink where to look for suggestions
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- Enable function signature help while typing parameters
      signature = { enabled = true },
    },
  },
}
