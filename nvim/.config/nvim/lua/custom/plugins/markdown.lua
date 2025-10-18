return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
  keys = {
    { '<leader>km', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle[K] [M]arkdown Preview' },
  },
}
