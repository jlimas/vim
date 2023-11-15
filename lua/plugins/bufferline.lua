return {
  'akinsho/bufferline.nvim',
  version = '*',
  after = 'catppuccin',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {},
  init = function()
    vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
    vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Next Buffer' })
  end,
}
