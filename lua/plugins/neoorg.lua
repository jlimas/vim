return {
  'nvim-neorg/neorg',
  dependencies = { 'nvim-lua/plenary.nvim' },
  build = ':Neorg sync-parsers',
  lazy = true,
  ft = 'norg',
  cmd = 'Neorg',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              yalo = '~/notes/yalo',
            },
          },
        },
      },
    }
  end,
}
