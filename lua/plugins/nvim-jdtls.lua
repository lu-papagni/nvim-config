return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local jdtls = require("jdtls")

    local jdtls_install = vim.fn.stdpath("data") .. "/jdtls"

    local path = {
      data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls",
      -- java_agent = jdtls_install .. "/lombok.jar",
      launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      runtimes = {
        --[[
        Note: the field `name` must be a valid `ExecutionEnvironment`,
        you can find the list here: 
        https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        
        This example assume you are using sdkman: https://sdkman.io
        {
          name = "JavaSE-17",
          path = vim.fn.expand("~/.sdkman/candidates/java/17.0.6-tem"),
        },
        {
          name = "JavaSE-18",
          path = vim.fn.expand("~/.sdkman/candidates/java/18.0.2-amzn"),
        },
        ]]--
      },
      bundles = {},
    }

    -- Seleziona la giusta configurazione in base al sistema operativo
    if vim.fn.has("unix") == 1 then
      path.platform_config = jdtls_install .. "/config_linux"
    elseif vim.fn.has("win32") == 1 then
      path.platform_config = jdtls_install .. "/config_win"
    elseif vim.fn.has("mac") == 1 then
      path.platform_config = jdtls_install .. "/config_mac"
    end

    local cache_vars = { paths = path }

    local data_dir = path.data_dir .. "/" ..  vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    if cache_vars.capabilities == nil then
      jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      cache_vars.capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        ok_cmp and cmp_lsp.default_capabilities() or {}
      )
    end

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx2g",   -- allocazione memoria max
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      path.launcher_jar,
      "-configuration",
      path.platform_config,
      "-data",
      data_dir,
    }

    local lsp_settings = {
      java = {
        -- jdt = {
        --   ls = {
        --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
        --   }
        -- },
        eclipse = { downloadSources = true },
        configuration = {
          updateBuildConfiguration = "interactive",
          runtimes = path.runtimes,
        },
        maven = { downloadSources = true },
        implementationsCodeLens = { enabled = false },
        referencesCodeLens = { enabled = false },
        inlayHints = {
          parameterNames = { enabled = "none" } -- literals, all, none 
        },
        format = {
          enabled = true,
          -- settings = {
          --   profile = "asdf"
          -- },
        }
      },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      contentProvider = { preferred = "fernflower" },
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    }

    -- jdtls deve agganciarsi ad ogni file java
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      desc = "Setup jdtls",
      callback = function()
        jdtls.start_or_attach {
          group = vim.api.nvim_create_augroup("java_cmds", { clear = true }),
          cmd = cmd,
          settings = lsp_settings,
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "<A-o>", function() jdtls.organize_imports() end, opts)
            vim.keymap.set("n", "crv", function() jdtls.extract_variable() end, opts)
            vim.keymap.set("x", "crv", function() jdtls.extract_variable(true) end, opts)
            vim.keymap.set("n", "crc", function() jdtls.extract_constant() end, opts)
            vim.keymap.set("x", "crc", function() jdtls.extract_constant(true) end, opts)
            vim.keymap.set("x", "crm", function() jdtls.extract_method(true) end, opts)
          end,
          capabilities = cache_vars.capabilities,
          root_dir = vim.fs.dirname(
            vim.fs.find({
              ".git",
              "mvnw",
              "gradlew",
              "pom.xml",
              "build.gradle",
            }, { upward = true })[1]
            or vim.fn.getcwd()
          ),
          flags = {
            allow_incremental_sync = true,
          },
          init_options = {
            bundles = path.bundles,
          },
        }
      end,
    })
  end
}
