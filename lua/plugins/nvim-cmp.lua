return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    cmp.event:on('menu_opened', function()
      vim.b.copilot_suggestion_hidden = false
    end)

    cmp.event:on('menu_closed', function()
      vim.b.copilot_suggestion_hidden = false
    end)

    cmp.setup {
      performance = {
        max_view_entries = 7,
      },
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
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.menu = ({
            copilot = '[Copilot]',
            luasnip = 'LuaSnip',
            nvim_lua = '[NVim Lua]',
            nvim_lsp = '[LSP]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]
          return vim_item
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
        -- { name = 'copilot' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'nvim_lua', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 3 },
        { name = 'path', keyword_length = 3 },
      },
    }
  end,
}
