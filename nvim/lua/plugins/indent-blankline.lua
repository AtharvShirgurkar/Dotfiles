return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  -- ADDED: Explicit dependency to ensure it loads after the theme
  dependencies = { 'catppuccin/nvim' },
  -- CHANGED: Replaced opts = {} with an explicit config function
  config = function()
    require('ibl').setup({
      -- Use a simple character for the indent lines
      indent = {
        char = "▏",
      },
      -- Disabled: This is the feature that causes the 'IblScope' error 
      -- when the highlight group is not available.
      scope = { enabled = false } 
    })
  end,
}
