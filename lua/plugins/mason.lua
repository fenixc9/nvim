return {

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
      opts.log_level = vim.log.levels.DEBUG
      opts.providers = { "mason.providers.client.golang", "mason.providers.registry", "mason.providers.client" }
    end,
  },
}
