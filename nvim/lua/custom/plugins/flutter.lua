return {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = function()
        return {
            lsp = {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
                settings = {
                    lineLength = 100,
                    showTodos = true,
                    completeFunctionCalls = true,
                },
            },
        }
    end,
}
