--- Generic LSP configuration

-- Filter noisy rust-analyzer messages
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
	if type(msg) == "string" and msg:match("overly long loop") then
		return
	end
	original_notify(msg, level, opts)
end

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
			hi! LspReferenceRead cterm=bold ctermbg=235 guibg=LightYellow
			hi! LspReferenceText cterm=bold ctermbg=235 guibg=LightYellow
			hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=LightYellow
		]])
		vim.api.nvim_create_augroup("lsp_document_highlight", {})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = 0,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = 0,
			callback = vim.lsp.buf.clear_references,
		})
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts, { desc = "Go to declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts, { desc = "Go to definition" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts, { desc = "Go to implementation" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts, { desc = "Show help for this symbol" })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts, { desc = "Show signature help" })
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts, { desc = "Add workspace folder" })
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		bufopts,
		{ desc = "Remove workspace folder" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts, { desc = "List workspace folders" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts, { desc = "Go to type definition" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts, { desc = "Rename symbol" })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts, { desc = "Rename symbol" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts, { desc = "Code action" })
	vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, bufopts, { desc = "Code action" })
	--vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts, { desc = "Go to references" })
	vim.keymap.set("n", "gr", function()
		vim.cmd([[Telescope lsp_references]])
	end, bufopts, { desc = "Go to references" })
	vim.keymap.set(
		"n",
		"gR",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		bufopts,
		{ desc = "Trouble LSP references" }
	)
	vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, bufopts, { desc = "Format buffer" })

	require("illuminate").on_attach(client)
end

--- Rust tools
vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", function()
				vim.cmd.RustLsp("codeAction")
			end, { buffer = bufnr }, { desc = "Code action group" })

			on_attach(client, bufnr)
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
				checkOnSave = true,
				check = {
					command = "clippy",
				},
				cargo = {
					features = "all",
				},
			},
		},
	},
	-- DAP configuration
	dap = {},
}

--- Python tools
vim.lsp.config("pyright", {
	on_attach = on_attach,
})

--- LSP diagnostics
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "󰋱" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = false,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
