return {

  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
          end,
        },
      }
    end,
    config = function() end,
  },
  {
    --    "mrcjkb/rustaceanvim",
    --    version = "^3", -- Recommended
    --    ft = { "rust" },
    --    opts = {
    --      server = {
    --        on_attach = function(client, bufnr)
    --          -- register which-key mappings
    --          local wk = require("which-key")
    --          wk.register({
    --            ["<leader>cR"] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
    --            ["<leader>dr"] = { function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables" },
    --          }, { mode = "n", buffer = bufnr })
    --        end,
    --        settings = {
    --          -- rust-analyzer language server configuration
    --          ["rust-analyzer"] = {
    --            cargo = {
    --              allFeatures = true,
    --              loadOutDirsFromCheck = true,
    --              runBuildScripts = true,
    --            },
    --            -- Add clippy lints for Rust.
    --            checkOnSave = {
    --              allFeatures = true,
    --              command = "clippy",
    --              extraArgs = { "--no-deps" },
    --            },
    --            procMacro = {
    --              enable = true,
    --              ignored = {
    --                ["async-trait"] = { "async_trait" },
    --                ["napi-derive"] = { "napi" },
    --                ["async-recursion"] = { "async_recursion" },
    --              },
    --            },
    --          },
    --        },
    --      }
    --    },
    --    config = function(_, opts)
    --      vim.g.rustaceanvim = vim.tbl_deep_extend("force",
    --        {},
    --        opts or {})
    --    end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        tsserver = {},
        pyright = {},
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
                closureReturnTypeHints = true,
                chainingHints = true,
                parameterHints = true,
                typeHints = true,
                lifetimeElisionHints = { enable = true, useParameterNames = true },
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
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
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
      setup = {
        rust_analyzer = function(_, opts)
          local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
          require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
          return true
        end,
      },
    },
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    --    "neovim/nvim-lspconfig",
    --    opts = {
    --      servers = {
    --        rust_analyzer = {},
    --        taplo = {
    --          keys = {
    --            {
    --              "K",
    --              function()
    --                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
    --                  require("crates").show_popup()
    --                else
    --                  vim.lsp.buf.hover()
    --                end
    --              end,
    --              desc = "Show Crate Documentation",
    --            },
    --          },
    --        },
    --      },
    --      setup = {
    --        rust_analyzer = function()
    --          return true
    --        end,
    --      },
    --    },
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml", "javascript", "html", "typescript", "css" })
        opts.highlight = {
          enable = true,
          vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = "#2779f5" }),
          vim.api.nvim_set_hl(0, "@lsp.type.enum.rust", { fg = "#15eb35" }),
          vim.api.nvim_set_hl(0, "@lsp.typemod.enum.library.rust", { fg = "#15eb35" }),
          vim.api.nvim_set_hl(0, "@lsp.typemod.enum.defaultLibrary.rust", { fg = "#15eb35" }),
          vim.api.nvim_set_hl(0, "@lsp.typemod.enumMember.defaultLibrary.rust", { fg = "#15eb35" }),
          vim.api.nvim_set_hl(0, "@lsp.type.typeAlias.rust", { fg = "#da27f5" }),
          vim.api.nvim_set_hl(0, "@lsp.type.typeParameter.rust", { fg = "#f5e105" }),
          vim.highlight.priorities.semantic_tokens == 300,
        }
      end
    end,
  },

  --  {
  --    "simrat39/rust-tools.nvim",
  --    lazy = true,
  --    opts = function()
  --      local ok, mason_registry = pcall(require, "mason-registry")
  --      local adapter ---@type any
  --      if ok then
  --        -- rust tools configuration for debugging support
  --        local codelldb = mason_registry.get_package("codelldb")
  --        local extension_path = codelldb:get_install_path() .. "/extension/"
  --        local codelldb_path = extension_path .. "adapter/codelldb"
  --        local liblldb_path = ""
  --        if vim.loop.os_uname().sysname:find("Windows") then
  --          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  --        elseif vim.fn.has("mac") == 1 then
  --          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  --        else
  --          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  --        end
  --        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  --      end
  --      return {
  --        dap = {
  --          adapter = adapter,
  --        },
  --        tools = {
  --          on_initialized = function()
  --            vim.cmd([[
  --                augroup RustLSP
  --                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
  --                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
  --                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
  --                augroup END
  --              ]])
  --          end,
  --        },
  --      }
  --    end,
  --    config = function() end,
  --  },

  {
    "rouge8/neotest-rust",
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
      opts.log_level = vim.log.levels.INFO
      opts.providers = {
        -- omitting registry-api provider, because it connects to https://api.mason-registry.dev/api/github/mason-org/mason-registry/releases/latest
        "mason.providers.client.golang",
      }
    end,
  },
}
