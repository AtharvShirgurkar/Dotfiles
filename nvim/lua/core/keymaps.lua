-- lua/core/keymaps.lua

-- Set Spacebar as the leader key
vim.g.mapleader = " "

-- 1. Toggle ALL diagnostics (Completely turns off/on the LSP warnings)
vim.keymap.set("n", "<leader>td", function()
  -- Neovim 0.11 native toggle command
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle ALL Diagnostics" })

-- 2. Toggle ONLY the inline text (Keeps the gutter icons, hides the text)
vim.keymap.set("n", "<leader>tv", function()
  local current_setting = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current_setting })
end, { desc = "Toggle Diagnostic Virtual Text" })

-- 3. Show error in a floating window (Useful if you hid the inline text!)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostic Float" })
