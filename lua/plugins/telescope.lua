return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Search Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Help Tags' })
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Search Marks Tags' })
  end,
}
