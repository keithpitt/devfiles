local function set_nvim_colorscheme()
  local env_colorscheme = os.getenv("COLORSCHEME")
  if env_colorscheme then
    vim.cmd("colorscheme " .. env_colorscheme)
  else
    -- Default colorscheme if the environment variable is not set
    vim.cmd("colorscheme default")
  end
end

set_nvim_colorscheme()
