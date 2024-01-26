return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  dependencies = {
    'rcarriga/nvim-notify',
  },
  config = function()
    require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/snippets/' }
  end,
}
