return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    init = function()
      vim.keymap.set('n', '\\', ':Neotree reveal toggle<cr>', { desc = 'Display Neotree' })
      vim.keymap.set('n', '<leader>e', ':Neotree reveal toggle<cr>', { desc = 'Display Neotree' })
    end,
  },
}
