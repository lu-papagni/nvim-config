return {
    'folke/trouble.nvim',
    opts = {
        focus = true,
        auto_close = true,
    },
    cmd = 'Trouble',
    keys = {
        { '<leader>x', '<cmd>Trouble diagnostics toggle<cr>' },
        { ']x',        '<cmd>Trouble diagnostics next<cr>' },
        { '[x',        '<cmd>Trouble diagnostics prev<cr>' },
    }
}
