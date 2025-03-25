return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        gopls = {},
        tsserver = {},
        pyright = {
          typeCheckingMode = "strict",
        },
        jsonls = {},
        rust_analyzer = {
          keys = {
            { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
            { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
            { "<leader>cc", "<cmd>RustRunnables<cr>", desc = "Run Runnables (Rust)" },
          },
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                -- closureReturnTypeHints = true,
                -- chainingHints = true,
                -- parameterHints = true,
                -- typeHints = true,
                -- lifetimeElisionHints = { enable = true, useParameterNames = true },
              },
              cache = {
                path = "/tmp/cache", -- 替换为你的缓存路径
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                -- ignored = {
                --   ["async-trait"] = { "async_trait" },
                --   ["napi-derive"] = { "napi" },
                --   ["async-recursion"] = { "async_recursion" },
                -- },
              },
            },
          },
        },
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {},
    },
  },
}
