-- plugins/rest.lua
return {
  'rest-nvim/rest.nvim',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  commit = '8b62563',
  config = function()
    local rest = require 'rest-nvim'

    vim.keymap.set('n', '<leader>rn', rest.run, { noremap = true })
    vim.keymap.set('n', '<leader>rl', rest.last, { noremap = true })
    vim.keymap.set('n', '<leader>rp', function()
      rest.run(true)
    end, { noremap = true })

    rest.setup {
      result_split_horizontal = false,
      result_split_in_place = false,
      env_file = '.env',
    }
  end,
}
