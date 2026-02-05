require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>cp", function() vim.cmd('let@+ = expand("%:p")') end, { desc = "Copy file path to clipboard" })
map("n", "<leader>crp", function() vim.cmd('let@+ = fnamemodify(expand("%"), ":.")') end, { desc = "Copy relative path from repo root" })

map('i', '<C-l>', function ()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = 'Copilot Accept', noremap = true, silent = true })

-- Add at the beginning of the file or where appropriate
if vim.g.vscode then
  local vscode = require('vscode')

  -- Normal mode keybindings for VSCode
  map('n', 'gi', function() vscode.action('editor.action.goToImplementation') end, { noremap = true })
  map('n', 'gr', function() vscode.action('references-view.findReferences') end, { noremap = true })
  map('n', '<leader>en', function() vscode.action('editor.action.marker.next') end, { noremap = true })
  map('n', '<leader>ep', function() vscode.action('editor.action.marker.prev') end, { noremap = true })
end

