local Utils = {}

Utils.get_symbols = function()
	return vim.lsp.buf.document_symbol()
end

return Utils
