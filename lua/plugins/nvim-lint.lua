return {
  'mfussenegger/nvim-lint',
  config = function()
    local notify = require 'notify'
    local nvimlint = require 'lint'

    nvimlint.linters_by_ft = {
      javascript = {},
      typescript = {},
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      callback = function()
        nvimlint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>leu', function()
      notify.notify('ESLint enabled', 'info', { title = 'Linters' })
      nvimlint.linters_by_ft.javascript = { 'eslint_d' }
      nvimlint.linters_by_ft.typescript = { 'eslint_d' }
    end, { desc = 'Enable ESLint' })

    vim.keymap.set('n', '<leader>led', function()
      notify.notify('ESLint disabled', 'warn', { title = 'Linters' })
      nvimlint.linters_by_ft.javascript = {}
      nvimlint.linters_by_ft.typescript = {}
    end, { desc = 'Disable ESLint' })

    -- Restart eslint_d
    local restartEsLintD = function()
      vim.cmd 'silent !eslint_d restart'
      notify.notify('Restarted ESLint', 'info', { title = 'Linters' })
    end
    vim.keymap.set('n', '<leader>re', restartEsLintD, { desc = 'Restart ESLint_D' })
  end,
}
