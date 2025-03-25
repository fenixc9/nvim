return {

  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^5", -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },

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
