---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["y"] = { '"+y', "yank with system clipboard" },
  },
  v = {
    ["y"] = { '"+y', "yank with system clipboard" },
  },
}

M.noice = {
  n = {
    ["<M-q>"] = { "<cmd> NoiceDismiss <cr>", "Dismiss all the stacked notification blocking the view" },
  },
  i = {
    ["<M-q>"] = { "<cmd> NoiceDismiss <cr>", "Dismiss all the stacked notification blocking the view" },
  },
}

M.ufo = {
  n = {
    ["zr"] = {
      function()
        require("ufo").openFoldsExceptKinds { "comment" }
      end,
      "󱞦 󱃄 Open All Folds except comments",
    },
    ["zm"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "󱞦 󱃄 Close All Folds",
    },
    ["z1"] = {
      function()
        require("ufo").closeFoldsWith(1)
      end,
      "󱞦 󱃄 Close L1 Folds",
    },
    ["z2"] = {
      function()
        require("ufo").closeFoldsWith(2)
      end,
      "󱞦 󱃄 Close L2 Folds",
    },
    ["z3"] = {
      function()
        require("ufo").closeFoldsWith(3)
      end,
      "󱞦 󱃄 Close L3 Folds",
    },
  },
}

M.mini_sessions = {
  n = {
    ["<leader>ys"] = { "<cmd> lua MiniSessions.select('read') <cr>", "Select available sessions to read" },
    ["<leader>yw"] = { "<cmd> lua MiniSessions.select('write') <cr>", "Select available sessions to write" },
    ["<leader>yd"] = { "<cmd> lua MiniSessions.select('delete') <cr>", "Select available sessions to delete" },
  },
}

M.mini_map = {
  n = {
    ["<leader>mx"] = { "<cmd> lua MiniMap.close() <cr>", "Close any open mini-map instance" },
    ["<leader>mf"] = { "<cmd> lua MiniMap.toggle_focus() <cr>", "Toggle focus on the mini-map instance" },
    ["<leader>mo"] = { "<cmd> lua MiniMap.open() <cr>", "Open mini-map for the current file" },
    ["<leader>mr"] = { "<cmd> lua MiniMap.refresh() <cr>", "Refresh the mini-map instance" },
    ["<leader>ms"] = { "<cmd> lua MiniMap.toggle_side() <cr>", "Toggle the side where the mini-map is shown" },
    ["<leader>mt"] = { "<cmd> lua MiniMap.toggle() <cr>", "Toggle open mini-map" },
  },
}

M.todo_comments = {
  n = {
    ["]t"] = {
      function()
        require("todo-comments").jump_next()
      end,
      "Next todo/highlighted comment",
    },
    ["[t"] = {
      function()
        require("todo-comments").jump_prev()
      end,
      "Previous todo/highlighted comment",
    },
  },
}

M.codeium = {
  i = {
    ["<M-;>"] = {
      function()
        return vim.fn["codeium#Accept"]()
      end,
      "Accept codeium suggestion",
      opts = { expr = true },
    },
    ["<M-.>"] = {
      function()
        return vim.fn["codeium#CycleCompletions"](1)
      end,
      "Next codeium suggestion",
      opts = { expr = true },
    },
    ["<M-,>"] = {
      function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end,
      "Previous codeium suggestion",
      opts = { expr = true },
    },
    ["<C-x>"] = {
      function()
        return vim.fn["codeium#Clear"]()
      end,
      "Clear current suggestion",
      opts = { expr = true },
    },
    ["<M-m>"] = {
      function()
        return vim.fn["codeium#Complete"]()
      end,
      "Manually trigger completion",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>td"] = {
      "<cmd> TroubleToggle document_diagnostics <cr>",
      "Toggle the document diagnostics",
      { silent = true, noremap = true },
    },
    ["<leader>tw"] = {
      "<cmd> TroubleToggle workspace_diagnostics <cr>",
      "Toggle the workspace diagnostics",
      { silent = true, noremap = true },
    },
    ["<leader>tl"] = {
      "<cmd> TroubleToggle loclist <cr>",
      "Toggle loclist window",
      { silent = true, noremap = true },
    },
    ["<leader>tf"] = {
      "<cmd> TroubleToggle quickfix <cr>",
      "Toggle the quickfix window",
      { silent = true, noremap = true },
    },
    ["<leader>tx"] = {
      "<cmd> TroubleClose <cr>",
      "Close trouble windows (if any)",
      { silent = true, noremap = true },
    },
    ["gR"] = {
      "<cmd> TroubleToggle lsp_references <cr>",
      "Toggle lsp references",
      { silent = true, noremap = true },
    },
  },
}

return M
