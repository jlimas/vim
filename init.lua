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
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_bold = false
      vim.cmd 'colorscheme nord'
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
vim.keymap.set('n', '<leader>w', ':w<cr>', { desc = 'Save File', silent = true })
vim.keymap.set('n', '<leader>q', ':q!<cr>', { desc = 'Close Window', silent = true })
vim.keymap.set('n', '<leader>x', ':qa!<cr>', { desc = 'Exit Vim', silent = true })

-- Buffer Management
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { desc = 'Delete Buffer', silent = true })
vim.keymap.set('n', '<leader>bc', ':close<cr>', { desc = 'Close Buffer', silent = true })
vim.keymap.set('n', '<leader>bp', ':BufferLinePickClose<cr>', { desc = 'Close Buffer Pick', silent = true })
vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<cr>', { desc = 'Close Other Buffers', silent = true })

-- Move between windows with Ctrl
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Resize Windows Height
vim.keymap.set('n', '<C-w>k', ':resize +10<cr>', { silent = true })
vim.keymap.set('n', '<C-w>j', ':resize -10<cr>', { silent = true })

-- Resize Windows Width
vim.keymap.set('n', '<C-w>l', ':vertical resize +10<cr>', { silent = true })
vim.keymap.set('n', '<C-w>h', ':vertical resize -10<cr>', { silent = true })

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    local notify = require 'notify'
    notify('Started Macro Recording', 'info', { title = 'Macros' })
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    local notify = require 'notify'
    notify('Stopped Macro Recording', 'warn', { title = 'Macros' })
  end,
})

-- Disable wrap
vim.o.wrap = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

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

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '~', extends = '❯', precedes = '❮' }

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
