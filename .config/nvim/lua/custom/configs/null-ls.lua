local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local fmt = null_ls.builtins.formatting
local diag = null_ls.builtins.diagnostics
local ca = null_ls.builtins.code_actions

local sources = {
	-- webdev stuff: [ js, ts, jsx, tsx, vue, css, scss, less, html, json, jsonc, yaml, md, mdx, graphql, handlebars]
	fmt.prettierd,
	-- Lua
	fmt.stylua,
	-- Dart
	fmt.dart_format,
	-- c, cpp, cs(c#), java, cuda, proto
	fmt.clang_format,
	-- linters
	diag.eslint_d,
	diag.alex.with({
		extra_filetypes = { "norg" },
	}),
	-- code actions
	ca.gitsigns,
	ca.eslint_d,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	border = "rounded",
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
