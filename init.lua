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
--
-- })
-- neovide配置
if vim.g.neovide then
  -- vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  -- vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  -- vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  -- vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  -- vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  -- vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  -- vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  -- vim.g.neovide_transparency = 0.8
  -- 性能分析
  vim.g.neovide_profiler = false
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  -- 全屏模式
  vim.g.neovide_fullscreen = true
  -- 强制重绘
  vim.g.neovide_no_idle = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_smooth_blink = false
  -- 粒子特效
  -- 可设置为 "railgun" "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe", 或空字符串 ""
  vim.g.neovide_cursor_vfx_mode = ""
  -- 刷新率
  vim.g.neovide_refresh_rate = 60
  --
  vim.g.neovide_cursor_vfx_particle_curl = 1.0
  vim.g.neovide_cursor_vfx_particle_speed = 2
  vim.g.neovide_cursor_antialiasing = true
end

vim.api.nvim_set_hl(0, "Visual", { ctermbg = "LightBlue", fg = "#04475a", bg = "#1f6fBB" })
