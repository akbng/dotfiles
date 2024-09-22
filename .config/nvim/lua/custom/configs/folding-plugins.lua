local present, ufo = pcall(require, "ufo") -- check if ufo is loaded

if not present then
  return
end

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

local foldIcon = "󱞦"
local hlgroup = "MoreMsg"

local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = "  " .. foldIcon .. "  " .. tostring(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, hlgroup })
  return newVirtText
end

local opts = {
  provider_selector = function(_, ft, _)
    -- INFO: some filetypes only allow indent, some only LSP, some only
    -- treesitter. However, ufo only accepts two kinds as priority,
    -- therefore making this function necessary
    local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css", "html", "python" }
    if vim.tbl_contains(lspWithOutFolding, ft) then
      return { "treesitter", "indent" }
    end
    return { "lsp", "indent" }
  end,
  close_fold_kinds_for_ft = {
    default = { 'imports', 'comment' },
    json = { "array" }
  },
  open_fold_hl_timeout = 150,
  fold_virt_text_handler = foldTextFormatter,
}

ufo.setup(opts)
