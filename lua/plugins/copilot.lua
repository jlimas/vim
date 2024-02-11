return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    local notify = require 'notify'
    local enabled = true

    vim.keymap.set('n', '=', function()
      enabled = not enabled
      local command = enabled and ':Copilot enable' or ':Copilot disable'
      local copilot_status = enabled and 'Enabled' or 'Disabled'
      local level = enabled and 'info' or 'warn'
      vim.cmd(command)
      notify.notify(copilot_status, level, { title = 'Copilot' })
    end, { desc = 'Toggle Copilot' })

    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<M-o>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    }
  end,
}
