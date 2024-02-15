return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    require('neodev').setup {}

    local hoverFunction = function()
      local util = require 'vim.lsp.util'
      vim.lsp.buf_request(0, 'textDocument/hover', util.make_position_params(), function(_, result, ctx, config)
        config = config or {}
        config.focus_id = ctx.method
        if not (result and result.contents) then
          -- return { 'No information available' }
          return
        end
        local markdown_lines = util.convert_input_to_markdown_lines(result.contents)
        -- trims beg and end of whole content
        markdown_lines = util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end

        -- print(dump(markdown_lines))
        vim.api.nvim_command [[ new ]]
        vim.api.nvim_buf_set_lines(0, 0, 1, false, markdown_lines)
        vim.api.nvim_command [[ setlocal ft=markdown ]]
        vim.api.nvim_command [[ nnoremap <buffer>q <C-W>c ]]
        vim.api.nvim_command [[ setlocal buftype+=nofile ]]
        vim.api.nvim_command [[ setlocal nobl ]]
        vim.api.nvim_command [[ setlocal conceallevel=2 ]]
        vim.api.nvim_command [[ setlocal concealcursor+=n ]]
        vim.api.nvim_command [[ resize 5 ]]
        -- vim.api.nvim_command [[ setlocal ft=lsp_markdown ]]
      end)
    end

    local lspconfig = require 'lspconfig'

    local util = require 'lspconfig.util'

    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.js', '*.ts' },
        callback = function(ctx)
          client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
        end,
      })

      -- set keybinds
      opts.desc = 'Show LSP references'
      keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)
      opts.desc = 'Go to declaration'
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      opts.desc = 'Show LSP definitions'
      keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

      opts.desc = 'Show LSP implementations'
      keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

      opts.desc = 'Show LSP type definitions'
      keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

      opts.desc = 'Show LSP Document Symbols'
      keymap.set('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>', opts)

      opts.desc = 'See available code actions'
      keymap.set({ 'n', 'v' }, '<leader>ca', ':Lspsaga code_action<CR>', opts)

      opts.desc = 'Smart rename'
      -- keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      keymap.set('n', '<leader>rn', ':Lspsaga rename<CR>', opts)

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

      opts.desc = 'Show line diagnostics'
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

      keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<cr>', { desc = 'Diagnostic Next' })
      keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { desc = 'Diagnostic Next' })
      keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { desc = 'Show documentation for what is under cursor' })
      keymap.set('n', '<leader>rs', '<cmd>LspRestart<cr>', { desc = 'Restart LSP' })
      keymap.set('n', '<leader>k', '<cmd>Lspsaga hover_doc ++keep<cr>', { desc = 'Hover Doc & Keep' })
      keymap.set('n', '<leader><leader>f', '<cmd>Lspsaga finder<cr>', { desc = 'Open LSP Finder' })
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    lspconfig['lua_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['pyright'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            logLevel = 'error',
            disableOrganizeImports = false,
            typeCheckingMode = 'off',
            diagnosticSeverityOverrides = {
              reportUndefinedVariable = 'none',
            },
          },
        },
      },
    }

    lspconfig['ruff_lsp'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        settings = {
          args = {},
        },
      },
    }

    lspconfig['emmet_ls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte', 'htmldjango' },
    }

    lspconfig['html'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'htmldjango' },
    }

    lspconfig['gopls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            uunusedparams = true,
          },
        },
      },
    }

    lspconfig['tsserver'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    }

    lspconfig['cssls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['tailwindcss'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['svelte'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['phpactor'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
