return {
  'phaazon/hop.nvim',
  config = true,
  init = function()
    vim.keymap.set('n', 's', ':HopPattern<cr>', {})
  end,
}
