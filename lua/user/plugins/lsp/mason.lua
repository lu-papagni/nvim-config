return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    cmd = { "Mason", "MasonInstall" },
    opts = {
        ui = {
            border = "rounded",
        }
    },
}
