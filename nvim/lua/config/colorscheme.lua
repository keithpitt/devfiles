local function set_nvim_colorscheme()
  local neovim_theme = os.getenv("NEOVIM_THEME") or os.getenv("COLORSCHEME")
  local neovim_theme_variant = os.getenv("NEOVIM_THEME_VARIANT")
  local neovim_background = os.getenv("NEOVIM_BACKGROUND")

  if neovim_theme then
    neovim_theme = neovim_theme:gsub('^"(.*)"$', '%1')
  end
  if neovim_theme_variant then
    neovim_theme_variant = neovim_theme_variant:gsub('^"(.*)"$', '%1')
  end
  if neovim_background then
    neovim_background = neovim_background:gsub('^"(.*)"$', '%1')
  end

  if not neovim_theme then
    vim.notify(
      "Set NEOVIM_THEME, you heathen.\nEnjoy this ugly blue theme.",
      vim.log.levels.WARN
    )
  end

  if neovim_background then
    vim.o.background = neovim_background
  end

  if neovim_theme == "ayu" and neovim_theme_variant then
    require('ayu').setup({
      mirage = (neovim_theme_variant == "mirage")
    })
  end

  if neovim_theme == "material" and neovim_theme_variant then
    vim.g.material_style = neovim_theme_variant
  end

  local theme_to_load = neovim_theme or "blue"
  local success, err = pcall(function()
    vim.cmd("colorscheme " .. theme_to_load)
  end)

  if not success then
    vim.notify(
      "Failed to load colorscheme '" .. theme_to_load .. "': " .. err .. "\n" ..
      "Set NEOVIM_THEME environment variable to a valid colorscheme.",
      vim.log.levels.ERROR
    )
    vim.cmd("colorscheme blue")
  end
end

-- Show current theme configuration and environment variables
-- Usage: :lua ShowThemeInfo()
function ShowThemeInfo()
  local info = {
    "Theme Configuration:",
    "-------------------",
    "NEOVIM_THEME: " .. (os.getenv("NEOVIM_THEME") or "not set"),
    "NEOVIM_THEME_VARIANT: " .. (os.getenv("NEOVIM_THEME_VARIANT") or "not set"),
    "NEOVIM_BACKGROUND: " .. (os.getenv("NEOVIM_BACKGROUND") or "not set"),
    "COLORSCHEME: " .. (os.getenv("COLORSCHEME") or "not set"),
    "",
    "Loaded theme: " .. (vim.g.colors_name or "not set"),
    "Background: " .. vim.o.background,
  }
  print(table.concat(info, "\n"))
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_nvim_colorscheme()
  end,
})
