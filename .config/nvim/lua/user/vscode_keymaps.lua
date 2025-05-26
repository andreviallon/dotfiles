local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<Space>', '', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.clipboard:append 'unnamedplus'

keymap('n', '<Esc>', ':noh<CR><Esc>', opts)

-- Yank to system clipboard
keymap({ 'n', 'v' }, '<leader>y', '"+y', opts)

-- Paste from system clipboard
keymap({ 'n', 'v' }, '<leader>p', '"+p', opts)

-- Paste preserves primal yanked piece
keymap('v', 'p', '"_dP', opts)

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 200 }
  end,
})

-- Indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Window navigation
keymap('n', '<C-h>', '<Cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>', opts)
keymap('n', '<C-l>', '<Cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>', opts)
keymap('n', '<C-k>', '<Cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>', opts)
keymap('n', '<C-j>', '<Cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>', opts)

-- Window splitting
keymap('n', '<leader>ss', '<Cmd>call VSCodeNotify("workbench.action.splitEditor")<CR>', opts)
keymap('n', '<leader>sS', '<Cmd>call VSCodeNotify("workbench.action.splitEditorDown")<CR>', opts)

-- Navigation
keymap('n', '<leader>.', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>', opts)

-- Notifications
keymap('n', '<leader>nn', '<Cmd>call VSCodeNotify("notifications.showList")<CR>', opts)

-- File Explorer
keymap('n', '<leader>e', '<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>', opts)

-- Search and Find
keymap('n', '<leader><Space>', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>', opts)
keymap('n', '<leader>ff', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>', opts)
keymap('n', '<leader>/', '<Cmd>call VSCodeNotify("workbench.action.findInFiles")<CR>', opts)

-- LSP
keymap('n', 'K', '<Cmd>call VSCodeNotify("editor.action.showHover")<CR>', opts)
keymap('n', '<leader>ca', '<Cmd>call VSCodeNotify("editor.action.codeAction")<CR>', opts)
keymap('n', '<leader>cr', '<Cmd>call VSCodeNotify("editor.action.rename")<CR>', opts)

-- Movement
keymap('v', '<C-j>', '<Cmd>call VSCodeNotify("editor.action.moveLinesDownAction")<CR>', opts)
keymap('v', '<C-k>', '<Cmd>call VSCodeNotify("editor.action.moveLinesUpAction")<CR>', opts)

-- Buffer navigation
keymap('n', '<leader>bo', '<Cmd>call VSCodeNotify("workbench.action.closeOtherEditors")<CR>', opts)
keymap('n', '<leader>br', '<Cmd>call VSCodeNotify("workbench.action.closeEditorsToTheRight")<CR>', opts)
keymap('n', '<leader>bl', '<Cmd>call VSCodeNotify("workbench.action.closeEditorsToTheLeft")<CR>', opts)
keymap('n', '<leader>bd', '<Cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>', opts)
keymap('n', '<leader>bp', '<Cmd>call VSCodeNotify("workbench.action.pinEditor")<CR>', opts)
keymap('n', '<leader>bP', '<Cmd>call VSCodeNotify("workbench.action.unpinEditor")<CR>', opts)
keymap('n', 'H', '<Cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)
keymap('n', 'L', '<Cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)

-- Goto
keymap('n', 'gd', '<Cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>', opts)
keymap('n', 'gs', '<Cmd>call VSCodeNotify("workbench.action.gotoSymbol")<CR>', opts)
keymap('n', 'gr', '<Cmd>call VSCodeNotify("editor.action.goToReferences")<CR>', opts)
keymap('n', 'gi', '<Cmd>call VSCodeNotify("editor.action.goToImplementation")<CR>', opts)

-- Git
keymap('n', '[c', '<Cmd>call VSCodeNotify("editor.action.dirtydiff.previous")<CR>', opts)
keymap('n', ']c', '<Cmd>call VSCodeNotify("editor.action.dirtydiff.next")<CR>', opts)
keymap(
  'n',
  '<leader>gG',
  '<Cmd>call VSCodeNotify("workbench.action.terminal.new")<CR><Cmd>call VSCodeNotify("workbench.action.terminal.sendSequence", {"text": "lazygit\\u000D"})<CR>',
  opts
)
keymap(
  'n',
  '<leader>gg',
  '<Cmd>call VSCodeNotify("workbench.action.createTerminalEditor")<CR><Cmd>call VSCodeNotify("workbench.action.terminal.sendSequence", {"text": "lazygit\\u000D"})<CR>',
  opts
)
keymap('n', '<leader>ga', '<Cmd>call VSCodeNotify("git.stage")<CR>', opts)
keymap('n', '<leader>gA', '<Cmd>call VSCodeNotify("git.stageAll")<CR>', opts)
keymap('n', '<leader>gu', '<Cmd>call VSCodeNotify("git.unstage")<CR>', opts)
keymap('n', '<leader>gU', '<Cmd>call VSCodeNotify("git.unstageAll")<CR>', opts)
keymap('n', '<leader>gs', '<Cmd>call VSCodeNotify("git.stageSelectedRanges")<CR>', opts)
keymap('n', '<leader>gS', '<Cmd>call VSCodeNotify("git.unstageSelectedRanges")<CR>', opts)
keymap('v', '<leader>gs', '<Cmd>call VSCodeNotify("git.stageSelectedRanges")<CR>', opts)
keymap('v', '<leader>gS', '<Cmd>call VSCodeNotify("git.unstageSelectedRanges")<CR>', opts)
keymap('n', '<leader>gd', '<Cmd>call VSCodeNotify("editor.action.dirtydiff.next")<CR>', opts)
keymap('n', '<leader>gD', '<Cmd>call VSCodeNotify("git.openChange")<CR>', opts)
keymap('n', '<leader>gr', '<Cmd>call VSCodeNotify("git.revertSelectedRanges")<CR>', opts)
keymap('n', '<leader>gR', '<Cmd>call VSCodeNotify("git.revertChange")<CR>', opts)
keymap('n', '<leader>gb', '<Cmd>call VSCodeNotify("gitlens.toggleFileBlame")<CR>', opts)

-- Diagnostics
keymap('n', '<leader>dd', '<Cmd>call VSCodeNotify("workbench.actions.view.problems")<CR>', opts)
keymap('n', '[d', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>', opts)
keymap('n', ']d', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>', opts)
keymap('n', '<leader>de', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>', opts)

-- Tests
keymap('n', '<leader>tT', '<Cmd>call VSCodeNotify("extension.runJestFile")<CR>', opts)
keymap('n', '<leader>tt', '<Cmd>call VSCodeNotify("extension.runJest")<CR>', opts)
keymap('n', '<leader>tr', '<Cmd>call VSCodeNotify("extension.runPrevJest")<CR>', opts)

-- Fold
keymap('n', '<leader>zf', '<Cmd>call VSCodeNotify("editor.fold")<CR>', opts)
keymap('n', '<leader>zF', '<Cmd>call VSCodeNotify("editor.unfold")<CR>', opts)

-- Bottom panel
keymap('n', '<leader>jg', '<Cmd>call VSCodeNotify("gitlens.openFileHistory")<CR>', opts)
keymap('n', '<leader>jt', '<Cmd>call VSCodeNotify("workbench.action.terminal.toggleTerminal")<CR>', opts)
keymap('n', '<leader>jo', '<Cmd>call VSCodeNotify("workbench.action.output.toggleOutput")<CR>', opts)
keymap('n', '<leader>jd', '<Cmd>call VSCodeNotify("workbench.actions.view.problems")<CR>', opts)
