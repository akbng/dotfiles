local present, neorg = pcall(require, "neorg")

if not present then
  return
end

local opts = {
  load = {
    ["core.export"] = {},
    ["core.export.markdown"] = {
      config = {
        extensions = "all",
      },
    },
    ["core.summary"] = {},
    ["core.journal"] = {
      config = {
        strategy = "flat",
      },
    },
    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          local leader = keybinds.leader
          keybinds.remap_event(
            "norg",
            "n",
            leader .. "lg",
            "core.looking-glass.magnify-code-block",
            { desc = "Open code block in separate buffer" }
          )
          keybinds.map(
            "norg",
            "n",
            leader .. "xx",
            "<cmd> Neorg exec cursor <cr>",
            { desc = "Execute code block under cursor" }
          )
          keybinds.map(
            "norg",
            "n",
            leader .. "xa",
            "<cmd> Neorg exec current-file <cr>",
            { desc = "Execute all code blocks in the file" }
          )
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
        icons = {
          heading = {
            icons = { "󰪥", "󰺕", "⦿", "", "ﰕ", "󰻂" }, -- load nerd-fonts icons
          },
          todo = {
            cancelled = { icon = "󰜺" },
            uncertain = { icon = "" },
            urgent = { icon = "" },
          },
        },
      },
    }, -- Adds pretty icons to your documents
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          fleet = "~/neo-zettel/fleeting",
          refs = "~/neo-zettel/references",
          perm = "~/neo-zettel/permanent",
          literature = "~/neo-zettel/literature",
          articles = "~/neo-zettel/articles",
          project = "~/neo-zettel/projects",
        },
        default_workspace = "fleet",
      },
    },
    ["core.presenter"] = {
      config = { zen_mode = "zen-mode" },
    },
    ["core.integrations.telescope"] = {},
    ["core.ui.calendar"] = {},
    ["external.exec"] = {
      config = {
        lang_cmds = {
          lua = {
            cmd = "luajit ${0}",
            type = "interpreted",
          },
        },
      },
    },
    ["external.templates"] = {
      config = {
        templates_dir = { "~/neo-zettel/templates/" },
      },
    },
  },
}

vim.wo.foldlevel = 99
vim.wo.conceallevel = 2

vim.api.nvim_create_autocmd("BufNewFile", {
  command = "Neorg templates fload journal",
  pattern = { "*/journal/*.norg" },
})

vim.api.nvim_create_autocmd("BufNewFile", {
  command = "Neorg templates fload article",
  pattern = { "~/neo-zettel/articles/*.norg" },
})

neorg.setup(opts)
