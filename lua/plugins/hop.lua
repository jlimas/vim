return {
  'phaazon/hop.nvim',
  config = true,
  init = function()
    vim.keymap.set('n', '<leader>s', ':HopPattern<cr>', {})
    vim.keymap.set('n', 'f', ':HopChar1<cr>', {})
  end,
}
