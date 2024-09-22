---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- overwrites
    ["y"] = { '"+y', "yank with system clipboard" },
    ["<leader>rf"] = { "<cmd> e! <cr>", "reload current file" },
    ["<C-w>>"] = { "5<C-w>>", "grow window width by 5" },
    ["<C-w><"] = { "5<C-w><", "shrink window width by 5" },
    ["<C-w>+"] = { "5<C-w>+", "grow window height by 5" },
    ["<C-w>-"] = { "5<C-w>-", "shrink window height by 5" },
    ["<C-u>"] = { "<C-u>zz", "Scroll up and center current line" },
    ["<C-d>"] = { "<C-d>zz", "Scroll down and center current line" },
  },
  i = {
    ["<C-BS>"] = { "<Esc>cvb", "delete previous word" },
  },
  v = {
    ["y"] = { '"+ygv<Esc>', "yank with system clipboard" },
  },
}

M.flutter = {
  n = {
    ["<leader>fr"] = { "<cmd> FlutterRun <cr>", "Flutter Run" },
    ["<leader>fR"] = { "<cmd> FlutterRestart <cr>", "Flutter Restart" },
    ["<leader>fq"] = { "<cmd> FlutterQuit <cr>", "Flutter Quit" },
    ["<leader>fx"] = { "<cmd> FlutterLogClear <cr>", "Flutter Clear Logs" },
    ["<leader>fd"] = { "<cmd> FlutterDevices <cr>", "Flutter Devices" },
  },
}

M.zen_mode = {
  n = {
    ["<leader>tz"] = { "<cmd> ZenMode <cr>", "Toggle Zen Mode" },
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

M.chatGPT = {
  n = {
    ["<leader>cg"] = { "<cmd> ChatGPT <cr>", "Open ChatGPT" },
    ["<leader>cr"] = { "<cmd> ChatGPTActAs <cr>", "Open ChatGPT prompt with select role" },
    ["<leader>ce"] = { "<cmd> ChatGPTRun explain_code <cr>", "Explain the codebase" },
  },
  v = {
    ["<leader>ce"] = { "<cmd> ChatGPTRun explain_code <cr>", "Explain the selected block of code" },
  },
}

M.icon_picker = {
  n = {
    ["<leader>fi"] = { "<cmd> IconPickerNormal <cr>", "Open icon picker" },
    ["<leader>fy"] = { "<cmd> IconPickerYank <cr>", "Open icon picker to yank" },
  },
  i = {
    ["<C-i>"] = { "<cmd> IconPickerInsert emoji <cr>", "Open icon picker in insert mode" },
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
      "<cmd> Trouble diagnostics toggle filter.buf=0 focus=true <cr>",
      "Toggle the document diagnostics",
      { silent = true, noremap = true },
    },
    ["<leader>tw"] = {
      "<cmd> Trouble diagnostics toggle <cr>",
      "Toggle the workspace diagnostics",
      { silent = true, noremap = true },
    },
    ["<leader>tl"] = {
      "<cmd> Trouble loclist toggle <cr>",
      "Toggle loclist window",
      { silent = true, noremap = true },
    },
    ["<leader>tf"] = {
      "<cmd> Trouble qflist <cr>",
      "Toggle the quickfix window",
      { silent = true, noremap = true },
    },
    ["<leader>tx"] = {
      function (opts)
        require("trouble").close(opts)
      end,
      "Close trouble windows (if any)",
      { silent = true, noremap = true },
    },
    ["gR"] = {
      "<cmd> Trouble lsp_references toggle <cr>",
      "Toggle lsp references",
      { silent = true, noremap = true },
    },
  },
}

return M
