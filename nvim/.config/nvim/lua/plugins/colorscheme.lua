return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
