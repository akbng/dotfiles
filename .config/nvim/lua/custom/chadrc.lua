---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "everforest_light" },
  hl_override = highlights.override,
  hl_add = highlights.add,
  statusline = {
    theme = "vscode_colored",
    separator_style = "block",
    overriden_modules = function(modules)
      table.insert(
        modules,
        2,
        (function()
          local available, _ = pcall(vim.fn["codeium#Accept"])
          if available then
            return "%#Assistant# " .. "%3{codeium#GetStatusString()} " .. "%#Normal#"
          end
        end)()
      )
    end,
  },
  telescope = {
    style = "bordered",
  },
  nvdash = {
    load_on_startup = true,
    header = require("custom.utils.logo")["random"],
    buttons = {
      { "  Saved Session", "Spc y s", "lua MiniSessions.select('read')" },
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
  extended_integrations = { "trouble", "notify", "rainbowdelimiters", "todo", "codeactionmenu" },
}
-- "%3{codeium#GetStatusString()} "
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
