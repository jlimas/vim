return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  dependencies = {
    'rcarriga/nvim-notify',
  },
  config = function()
    local ls = require 'luasnip'

    require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/snippets/' }
    require('luasnip').config.setup { store_selection_keys = '<A-p>' }

    vim.keymap.set('n', '<Leader><CR>', '<cmd>LuaSnipEdit<cr>', { silent = true, noremap = true })

    vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

    ls.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
    }

    vim.keymap.set({ 'i' }, '<C-K>', function()
      ls.expand()
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-L>', function()
      ls.jump(1)
    end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-J>', function()
      ls.jump(-1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-E>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })
  end,
}
