return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
      open_mapping = [[<c-\>]],
    },
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'Lazygit' })
    end,
  },
}
