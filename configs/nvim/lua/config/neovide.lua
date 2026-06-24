if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = ""

  vim.o.guifont = 'JetBrainsMono Nerd Font:h10'

  vim.keymap.set({ "n", "v" }, "<C-+>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end)

  vim.keymap.set({ "n", "v" }, "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end)

  vim.keymap.set({ "n", "v" }, "<C-0>", function()
    vim.g.neovide_scale_factor = 1
  end)
end
