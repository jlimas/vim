return {
  'michaelb/sniprun',
  branch = 'master',
  build = 'sh install.sh',
  config = function()
    require('sniprun').setup {
      display = { 'TempFloatingWindow' },
      borders = 'double',
    }
    vim.api.nvim_set_keymap('v', '<cr>', '<Plug>SnipRun', { silent = true })
  end,
}
