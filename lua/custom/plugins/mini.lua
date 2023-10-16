return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.comment').setup {}
    require('mini.surround').setup {}
    require('mini.files').setup {}

    vim.keymap.set('n', '-', MiniFiles.open, { desc = 'File Explorer' })
  end,
}
