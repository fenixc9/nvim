return {
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
}
