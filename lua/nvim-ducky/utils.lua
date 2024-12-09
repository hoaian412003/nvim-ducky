local Utils = {}

function Utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

return Utils
