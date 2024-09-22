require("mini.surround").setup()
require("mini.animate").setup {
  scroll = {
    enable = false,
  },
}
require("mini.bufremove").setup()
require("mini.sessions").setup()

local map = require "mini.map"
require("mini.map").setup {
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.gitsigns(),
    map.gen_integration.diagnostic(),
  },
}
