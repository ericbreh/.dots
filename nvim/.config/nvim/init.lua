-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"