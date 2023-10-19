return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'
    oil.setup {}
    vim.keymap.set('n', '-', function()
      oil.open_float(nil)
    end, { desc = 'File Explorer' })
  end,
}
