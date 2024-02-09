return {
  'mfussenegger/nvim-lint',
  config = function()
    local notify = require 'notify'

    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })

    -- Restart eslint_d
    local restartEsLintD = function()
      vim.cmd 'silent !eslint_d restart'
      notify.notify('Restarted ESLint', 'info', { title = 'Linters' })
    end
    vim.keymap.set('n', '<leader>re', restartEsLintD, { desc = 'Restart ESLint_D' })
  end,
}
