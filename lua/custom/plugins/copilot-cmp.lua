return {
  'zbirenbaum/copilot-cmp',
  dependencies = {
    'rcarriga/nvim-notify',
  },
  config = function()
    require('copilot_cmp').setup()
    local notify = require 'notify'

    local enable = function()
      vim.cmd ':Copilot enable'
      notify('Ready', 'info', { title = 'Copilot' })
    end

    local disable = function()
      vim.cmd ':Copilot disable'
      notify('Disabled', 'warn', { title = 'Copilot' })
    end

    disable()

    vim.keymap.set('n', '<leader>cu', enable, { desc = 'Enable Copilot' })
    vim.keymap.set('n', '<leader>cd', disable, { desc = 'Disable Copilot' })
  end,
}
