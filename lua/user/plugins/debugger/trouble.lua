return {
    'folke/trouble.nvim',
    opts = {
        focus = true,
        auto_close = true,
    },
    cmd = 'Trouble',
    keys = {
        { '<leader>dm', '<cmd>Trouble diagnostics toggle<cr>' },
        { ']d',         '<cmd>Trouble diagnostics next<cr>' },
        { '[d',         '<cmd>Trouble diagnostics prev<cr>' },
    }
}
