return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  keys = {
    { '<leader>kn', '<cmd>NoNeckPain<cr>', desc = 'Toggle[K] [N]oNeckPain' },
  },
  opts = {
    width = 130,
  },
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.cmd 'NoNeckPain'
      end,
    })
  end,
}
