return {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
        local mason = require("user.macro.mason-ensure")
        local dap = require("dap")

        mason.ensure({
            "codelldb",
        })

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = vim.fn.exepath('OpenDebugAD7'),
            options = {
                detached = false
            }
        }

        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = vim.fn.exepath('codelldb'),
                args = { '--port', '${port}' },
            },
        }

        dap.configurations.c = {
            {
                name = 'LLDB (Unix)',
                type = 'codelldb',
                request = 'launch',
                program = '${workspaceFolder}/${fileBasenameNoExtension}',
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                console = 'integratedTerminal',
            },
            {
                name = "CPPTOOLS (Windows)",
                type = "cppdbg",
                request = "launch",
                program = '${workspaceFolder}\\${fileBasenameNoExtension}',
                cwd = '${workspaceFolder}',
                setupCommands = {
                    {
                        description = 'Enable pretty-printing for gdb',
                        text = '-enable-pretty-printing',
                        ignoreFailures = false
                    }
                },
                miDebuggerPath = vim.fn.exepath('gdb'),
                externalConsole = false,
                MIMode = 'gdb',
                miDebuggerArgs = '',
                args = {},
                environment = {},
                internalConsoleOptions = 'openOnSessionStart',
                stopOnEntry = false,
                logging = {
                    module = true,
                    dap = true,
                    request = true,
                    responses = true
                }
            },
        }

        dap.configurations.cpp = dap.configurations.c
    end
}
