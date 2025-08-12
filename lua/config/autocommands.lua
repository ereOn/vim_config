-- Automatically unfold folds in small files.
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)

		if line_count < 200 then
			vim.cmd("normal! zi")
		end
	end,
})

-- Custom filetypes.
events = { "BufRead", "BufNewFile" }

for _, event in ipairs(events) do
	vim.api.nvim_create_autocmd({ event }, {
		pattern = { "justfile" },
		callback = function()
			vim.opt_local.filetype = "just"
		end,
	})

	vim.api.nvim_create_autocmd({ event }, {
		pattern = { "*.html.jinja", "*.html.jinja2" },
		callback = function()
			vim.opt_local.filetype = "htmldjango"
		end,
	})
end
