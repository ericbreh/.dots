return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    keys = {
      { '<leader>km', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle Markdown Preview' },
      {
        '<leader>kp',
        function()
          local current_file = vim.fn.expand '%'
          local pdf_file = vim.fn.expand '%:r' .. '.pdf'
          local command = '!pandoc ' .. current_file .. ' -o ' .. pdf_file .. ' && xdg-open ' .. pdf_file
          vim.cmd(command)
        end,
        desc = 'Convert to PDF using Pandoc',
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ft = { 'markdown' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      enabled = true,
      sign = { enabled = false },
      heading = {
        backgrounds = {},
        position = 'inline',
      },
      code = {
        width = 'block',
        left_pad = 2,
        right_pad = 2,
      },
    },
    keys = {
      { '<leader>kr', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Render Markdown' },
    },
  },
}
