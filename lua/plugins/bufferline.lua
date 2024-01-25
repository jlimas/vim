return {
  'akinsho/bufferline.nvim',
  version = '*',
  after = 'catppuccin',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
    }
  end,
  init = function()
    vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next Buffer', silent = true })
    vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Next Buffer', silent = true })
  end,
}
