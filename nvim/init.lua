-- [[ Global Variables ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

if vim.g.vscode then
  require 'user.vscode_keymaps'
else
  vim.opt.wrap = false
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.mouse = 'a'
  vim.opt.showmode = false
  vim.opt.breakindent = true
  vim.opt.undofile = true
  vim.opt.signcolumn = 'yes'
  vim.opt.updatetime = 250
  vim.opt.timeoutlen = 300
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
  vim.opt.inccommand = 'split'
  vim.opt.cursorline = true
  vim.opt.scrolloff = 15
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Sync clipboard between OS and Neovim.
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)

  -- Clear highlights on search when pressing <Esc> in normal mode
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Lazy
  vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

  -- Diagnostics
  vim.keymap.set('n', '<leader>ud', vim.diagnostic.setloclist, { desc = 'Toggle diagnostic quickfix list' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic message' })
  vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open diagnostic error message' })
  vim.keymap.set('n', '<leader>uD', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { silent = true, noremap = true })
  vim.diagnostic.config {
    virtual_text = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    underline = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = true,
    update_in_insert = false,
  }
  vim.keymap.set('n', '<leader>dE', function()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics == 0 then
      print 'No diagnostics found'
      return
    end

    local messages = {}
    for _, diag in ipairs(diagnostics) do
      table.insert(messages, diag.message)
    end

    local output = table.concat(messages, '\n')

    vim.fn.setreg('+', output)
    print 'Diagnostics copied to clipboard!'
  end, { desc = 'Copy Diagnostics' })

  -- Move lines up and down
  vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
  vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

  -- Window
  vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>sh', ':split<Return>', { desc = 'Split window below', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ss', ':vsplit<Return>', { desc = 'Split window right', noremap = true, silent = true })
  vim.keymap.set('n', '<C-w><left>', '15<C-w><', { desc = 'Resize window left', noremap = true, silent = true })
  vim.keymap.set('n', '<C-w><right>', '15<C-w>>', { desc = 'Resize window right', noremap = true, silent = true })
  vim.keymap.set('n', '<C-w><up>', '5<C-w>+', { desc = 'Resize window up', noremap = true, silent = true })
  vim.keymap.set('n', '<C-w><down>', '5<C-w>-', { desc = 'Resize window down', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>wQ', function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end, { noremap = true, silent = true, desc = 'Close window and buffer' })

  -- Buffer
  vim.keymap.set('n', '<leader>bo', ':%bd|e#|bd# <CR>', { desc = 'Delete other buffers' })
  vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
  vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
  vim.keymap.set('n', '<leader>bd', ':bd|e# <CR>', { desc = 'Delete buffer' })
  vim.keymap.set('n', '<leader>bD', '<Cmd>:bw!<CR>', { desc = 'Delete buffer force', noremap = true, silent = true })
  vim.keymap.set('n', '<leader>bo', function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
      if b ~= bufnr and vim.api.nvim_buf_is_loaded(b) then
        vim.api.nvim_buf_delete(b, {})
      end
    end
  end, { desc = 'Close other buffers' })

  -- Snippets
  vim.keymap.set('i', '<C-l>', function()
    local input = vim.fn.input 'Console log with description: '
    local line = string.format("console.log('%s', %s);", input, input)
    vim.api.nvim_put({ line }, 'l', true, true)
  end, { desc = 'Insert console.log with label', noremap = true, silent = true })

  -- Lazyvim
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
    end
  end ---@diagnostic disable-next-line: undefined-field
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup {
    install = { colorscheme = { 'catppuccin' } },
    -- require 'kickstart.plugins.debug',
    require 'kickstart.plugins.indent_line',
    require 'kickstart.plugins.lint',
    require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    require 'kickstart.plugins.gitsigns',
    { import = 'custom.plugins' },
  }
end
