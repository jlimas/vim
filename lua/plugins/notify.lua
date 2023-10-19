return {
  'rcarriga/nvim-notify',
  after = 'catppuccin',
  config = function()
    local notify = require 'notify'
    notify.setup {
      stages = 'slide',
    }
    vim.notify = notify
  end,
}
