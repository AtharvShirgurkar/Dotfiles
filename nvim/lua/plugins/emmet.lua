return {
  'olrtg/nvim-emmet',
  event = 'InsertEnter',
  config = function()
    -- This keymap allows you to expand Emmet abbreviations
    -- For example, type 'div>p' and then press <leader>xe in normal or visual mode
    vim.keymap.set({ 'n', 'v' }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
  end,
}
