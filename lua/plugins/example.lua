-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
--if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- copilot 状态
  { "ofseed/copilot-status.nvim" },

  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },


}
