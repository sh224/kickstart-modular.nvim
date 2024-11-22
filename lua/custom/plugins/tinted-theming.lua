local default_theme = 'base16-default-dark'

local function get_tinty_theme()
  local theme_name = vim.fn.system 'tinty current &> /dev/null && tinty current'

  if vim.v.shell_error ~= 0 then
    return default_theme
  else
    return theme_name
  end
end

local function main()
  local current_theme_name = get_tinty_theme()

  vim.cmd('colorscheme ' .. current_theme_name)

  -- fix @variable not set by tinted theme
  vim.api.nvim_set_hl(0, '@variable', { link = '@variable.builtin' })
end

return {
  'tinted-theming/base16-vim',
  priority = 1000,
  config = function()
    -- vim.o.termguicolors = true
    vim.g.base16_colorspace = 256
    vim.g.base16_background_transparent = 1
    main()
  end,
}
