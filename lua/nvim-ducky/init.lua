local M = {} -- public method

function M.health_check()
	if vim.lsp == nil then
		error("Lsp client is not configured")
	end
end

return M
