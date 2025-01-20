return {

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
      opts.log_level = vim.log.levels.DEBUG
      opts.providers =
        { -- omitting registry-api provider, because it connects to https://api.mason-registry.dev/api/github/mason-org/mason-registry/releases/latest "mason.providers.client.golang", "mason.providers.registry", "mason.providers.client",
        }
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
}
