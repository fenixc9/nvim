return {

  {
    "Pocco81/auto-save.nvim",
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = { "InsertLeave" },
    conditions = {
      exists = true,
      filetype_is_not = {},
      modifiable = true,
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 2500,
    debounce_delay = 500,
  },
}
