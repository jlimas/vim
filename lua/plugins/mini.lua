return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.comment').setup {}
    require('mini.surround').setup {}
    require('mini.animate').setup {}
  end,
}
