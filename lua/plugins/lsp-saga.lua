return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup {
      hover = {
        max_width = 0.5,
        max_height = 0.8,
        open_link = 'gx',
        open_cmd = '!chrome',
      },
      lightbulb = {
        enable = false,
      },
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
