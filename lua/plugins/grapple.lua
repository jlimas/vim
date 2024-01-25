return {
  'cbochs/grapple.nvim',
  config = function()
    local grapple = require 'grapple'
    local notify = require 'notify'
    grapple.setup {}

    vim.keymap.set('n', '<leader>m', function()
      grapple.tag { scope = 'git' }
      notify.notify('Added to marks', 'success', { title = 'Grapple' })
    end, { desc = 'Grapple Mark' })

    vim.keymap.set('n', '<leader>M', function()
      grapple.untag { scope = 'git' }
      notify.notify('Removed from marks', 'warn', { title = 'Grapple' })
    end, { desc = 'Grapple Remove Mark' })

    vim.keymap.set('n', '<leader>jf', function()
      grapple.popup_tags 'git'
    end, { desc = 'Grapple Display Tags' })

    vim.keymap.set('n', '<leader>jJ', function()
      require('grapple').toggle { key = 'main' }
      notify.notify('File marked as [main]', 'success', { title = 'Grapple' })
    end, { desc = 'Grapple Mark [main]' })

    vim.keymap.set('n', '<leader>jj', function()
      require('grapple').select { key = 'main' }
      notify.notify('Moved to [main]', 'success', { title = 'Grapple' })
    end, { desc = 'Grapple Move [main]' })

    vim.keymap.set('n', '<leader>jK', function()
      require('grapple').toggle { key = 'ref' }
      notify.notify('File marked as [ref]', 'success', { title = 'Grapple' })
    end, { desc = 'Grapple Mark [ref]' })

    vim.keymap.set('n', '<leader>jk', function()
      require('grapple').select { key = 'ref' }
      notify.notify('Moved to [ref]', 'success', { title = 'Grapple' })
    end, { desc = 'Grapple Move [ref]' })
  end,
}
