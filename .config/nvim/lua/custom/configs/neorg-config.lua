local present, neorg = pcall(require, "neorg")

if not present then
  return
end

local opts = {
  load = {
    ["core.export"] = {},
    ["core.summary"] = {},
    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          local leader = keybinds.leader
          keybinds.remap_event("norg", "n", leader .. "lg", "core.looking-glass.magnify-code-block")
        end,
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.concealer"] = {
      config = {
        icon_preset = "basic",
      },
    }, -- Adds pretty icons to your documents
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
    ["core.ui.calendar"] = {},
  },
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

neorg.setup(opts)
