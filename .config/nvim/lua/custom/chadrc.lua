---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "rosepine",
  theme_toggle = { "rosepine", "ayu_light" },
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
            return "%3{codeium#GetStatusString()}"
          end
        end)()
      )
    end,
  },
  telescope = {
    style = "bordered",
  },
}
-- "%3{codeium#GetStatusString()} "
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
