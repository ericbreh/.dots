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
    {
      '<leader>kp',
      function()
        local current_file = vim.fn.expand('%')
        local pdf_file = vim.fn.expand('%:r') .. '.pdf'
        local command = '!pandoc ' .. current_file .. ' -o ' .. pdf_file .. ' && xdg-open ' .. pdf_file
        vim.cmd(command)
      end,
      desc = 'Convert to PDF using Pandoc',
    },
  },
}
