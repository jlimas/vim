return {
  'zbirenbaum/copilot-cmp',
  dependencies = {
    'rcarriga/nvim-notify',
  },
  config = function()
    require('copilot_cmp').setup()
    local notify = require 'notify'
    local enabled = false

    local function display_notification(title, level, message)
      notify.dismiss { silent = true, pending = true }
      notify(title, level, { title = message, timeout = 2000 })
    end

    local enable = function()
      enabled = true
      vim.cmd ':Copilot enable'
      display_notification('¡Vamos!', 'info', 'Copilot')
    end

    local disable = function(show)
      enabled = false
      vim.cmd ':Copilot disable'
      if show then
        display_notification('¡Descansando!', 'warn', 'Copilot')
      end
    end

    local toggle = function()
      if enabled then
        disable(true)
      else
        enable()
      end
    end

    disable(false)

    vim.keymap.set('n', '=', toggle, { desc = 'Toggle Copilot' })
  end,
}
