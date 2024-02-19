return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Search Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Help Tags' })
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Search Marks Tags' })
    vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = 'Search Marks Tags' })

    telescope.setup {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    }

    telescope.load_extension 'fzf'
  end,
}
