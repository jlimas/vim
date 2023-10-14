return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'

    local luasnip = require 'luasnip'

    local reverse_prioritize = function(entry1, entry2)
      if entry1.copilot and not entry2.copilot then
        return false
      elseif entry2.copilot and not entry1.copilot then
        return true
      end
    end

    local cmp_config_default = require 'cmp.config.default'()
    local copilot_prioritize = require('copilot_cmp.comparators').prioritize
    local copilot_reverse_prioritize = function(entry1, entry2)
      return not copilot_prioritize(entry1, entry2)
    end

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      window = {
        completion = {
          border = 'rounded',
        },
        documentation = {
          border = 'rounded',
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = false },
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp', group_index = 1, max_item_count = 5 },
        { name = 'copilot', group_index = 1, max_item_count = 5 },
        { name = 'buffer', group_index = 2, max_item_count = 5 },
        { name = 'path', group_index = 2, max_item_count = 5 },
      },
      sorting = {
        priority_weight = 1,
        comparators = table.insert(cmp_config_default.sorting.comparators, 1, copilot_reverse_prioritize),
      },
    }
  end,
}
