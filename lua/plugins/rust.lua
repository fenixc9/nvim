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

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = { adapters = { ["neotest-rust"] = {} } },
  },
  {},

  { "nvim-neotest/nvim-nio" },
}
