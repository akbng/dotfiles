local present, neorg = pcall(require, "neorg")

if not present then
  return
end

local opts = {
  load = {
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
  },
}

neorg.setup(opts)
