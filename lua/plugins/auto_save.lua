return {
  {
    "Pocco81/auto-save.nvim",
    enabled = true,
    opts = {

      execution_message = {
        message = function() -- message to print on save
          return "AutoSave"
        end,

        dim = 0.1, -- dim the color of `message`

        cleaning_interval = 250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },

      events = { "InsertLeave" },

      conditions = {
        exists = true,
        filetype_is_not = {},
        modifiable = true,
      },
      write_all_buffers = false,
      on_off_commands = false,
      clean_command_line_interval = 0,
      debounce_delay = 500,
      callbacks = { -- functions to be executed at different intervals
        enabling = nil, -- ran when enabling auto-save
        disabling = nil, -- ran when disabling auto-save
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil, -- ran before doing the actual save
        after_saving = nil, -- ran after doing the actual save
      },
    },
  },
}
