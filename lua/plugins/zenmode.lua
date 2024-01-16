-- Lua
return {
  'folke/zen-mode.nvim',
  config = function()
    vim.keymap.set('n', '<leader>z', function()
      require('zen-mode').toggle {
        window = {
          width = 150,
        },
      }
    end, { desc = 'Zen Mode' })
  end,
}
