return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        go = { 'goimports', 'gofmt' },
        yaml = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier', 'eslint_d' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        markdown = { 'prettier' },
        svelte = { 'prettier', 'eslint_d' },
      },
      format_on_save = {
        timeout_ms = 2500,
        lsp_fallback = true,
      },
    },
  },
}
