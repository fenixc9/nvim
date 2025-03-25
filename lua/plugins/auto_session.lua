vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal" -- ,globals,options,localoptions
return {
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "~/project/leetcode/" },
      auto_restore_last_session = false,
      auto_session_enabled = true, -- 启用自动保存和恢复
      auto_save_enabled = true, -- 自动保存会话
      auto_restore_enabled = true, -- 自动恢复会话
      auto_session_suppress_dirs = { "~/project/leetcode/", "/tmp" }, -- 忽略的目录
      auto_session_create_enabled = true, -- 允许自动创建会话
      auto_session_enable_last_session = true, -- 即使指定了文件或目录也恢复会话
      pre_save_cmds = {},
    },
  },
}
