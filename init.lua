-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.laststatus = 3
vim.o.cursorline = true
vim.api.nvim_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-e>", "<C-u>", { noremap = true, silent = true })
-- 修改 Go 常量的颜色
vim.api.nvim_set_hl(0, "goConstant", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "@constant", { fg = "#FFFF00" })
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   paste = {
--     ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--   },
-- }
-- 切换到 Normal 模式时自动切换为英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.fn.system("im-select com.apple.keylayout.ABC") -- macOS
    -- vim.fn.system('im-select 1033')  -- Windows
    -- vim.fn.system('im-select xkb:us::eng')  -- Linux
  end,
})
-- vim.api.nvim_create_autocmd("VimLeave", {
--   pattern = "*",
--   callback = function()
--     os.execute("rm -rf ~/.local/share/nvim/blink/cmp/fuzzy.db")
--   end,
-- })
