return {
  'andythigpen/nvim-coverage',
  cmd = { 'Coverage', 'CoverageSummary', 'CoverageToggle' },
  config = function()
    local coverage = require 'coverage'
    coverage.setup {}
    vim.keymap.set('n', '<leader>ccj', '<cmd>Coverage<cr>', { desc = 'Coverage Show' })
    vim.keymap.set('n', '<leader>ccs', '<cmd>CoverageSummary<cr>', { desc = 'Coverage Summary' })
    vim.keymap.set('n', '<leader>cct', '<cmd>CoverageToggle<cr>', { desc = 'Coverage Toggle' })
  end,
}
