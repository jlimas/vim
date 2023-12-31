vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme Color Scheme
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        integrations = {
          cmp = true,
          harpoon = true,
          mason = true,
          neotree = true,
          gitsigns = true,
          hop = true,
          telescope = {
            enabled = true,
          },
          lsp_trouble = true,
          indent_blankline = {
            enabled = true,
          },
          which_key = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = {},
              hints = {},
              warnings = {},
              information = {},
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
        styles = {
          comments = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
      }
      vim.cmd [[colorscheme catppuccin-frappe]]
    end,
  },

  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'folke/neodev.nvim',

  { import = 'plugins' },
  { import = 'plugins.lsp' },
}, {})

vim.cmd 'highlight Pmenu guibg=NONE'
vim.cmd 'highlight Float guibg=NONE'
vim.cmd 'highlight NormalFloat guibg=NONE'

-- Custom Keybindings
vim.keymap.set('i', 'jk', '<esc>', {})
vim.keymap.set('n', '<leader>w', ':w<cr>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>q', ':q!<cr>', { desc = 'Close Window' })
vim.keymap.set('n', '<leader>x', ':qa!<cr>', { desc = 'Exit Vim' })

-- Buffer Management
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bcp', ':BufferLinePickClose<cr>', { desc = 'Close Buffer Pick' })
vim.keymap.set('n', '<leader>bco', ':BufferLineCloseOthers<cr>', { desc = 'Close Other Buffers' })

-- Move between windows with Ctrl
vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})

-- Resize Windows Height
vim.keymap.set('n', '<C-w>k', ':resize +10<cr>', {})
vim.keymap.set('n', '<C-w>j', ':resize -10<cr>', {})

-- Resize Windows Width
vim.keymap.set('n', '<C-w>l', ':vertical resize +10<cr>', {})
vim.keymap.set('n', '<C-w>h', ':vertical resize -10<cr>', {})

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Generic Configuration
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.diagnostic.config {
  float = { border = 'rounded' },
}

vim.api.nvim_create_user_command('CopyFilePath', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
