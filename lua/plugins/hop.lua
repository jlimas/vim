return {
  'phaazon/hop.nvim',
  config = true,
  init = function()
    vim.keymap.set('n', 's', ':HopPattern<cr>', {})
    vim.keymap.set('n', 'f', ':HopChar1<cr>', {})
  end,
}
