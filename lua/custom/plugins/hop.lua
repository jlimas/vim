return {
  'phaazon/hop.nvim',
  config = true,
  init = function()
    vim.keymap.set('n', 'f', ':HopChar2<cr>', {})
  end,
}
