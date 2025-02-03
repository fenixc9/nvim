return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  opts = {
    sources = {
      "filesystem", -- 只启用文件系统源
      -- 'buffers',  -- 禁用 buffer 源
      -- "git_status", -- 可选：禁用 git 状态源
    },
    filters = {
      show_hidden = true,
      hide_dotfiles = false, -- 不隐藏以点开头的文件
      hide_gitignored = false, -- 不隐藏 .gitignore 中忽略的文件
    },
    enable_git_status = true,
    enable_diagnostics = false,
    default_component_configs = {
      window = {
        position = "left",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<C-n>"] = "move_cursor_down",
          ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = false,
              -- use_image_nvim = true,
              -- title = 'Neo-tree Preview',
            },
          },
        },
      },
      indent = {
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      git_status = {
        refresh_interval = 2000,
        symbols = {
          -- Change type
          added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "D",
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
      file_size = {
        required_width = 64, -- min width of window required to show this column
        enabled = true,
      },
    },
  },
}
