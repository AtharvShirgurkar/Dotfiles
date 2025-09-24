return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    local keymap = vim.keymap

    -- General Keymaps
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })

    -- Optional: a more advanced keymap for searching the current word
    keymap.set('n', '<leader>fw', function()
      builtin.grep_string({ search = vim.fn.expand('<cword>') })
    end, { desc = 'Find word under cursor' })
  end,
}
