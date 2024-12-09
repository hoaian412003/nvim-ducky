local Utils = {}

-- lua print(require('nvim-ducky').utils.get_symbols())
function Utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

return Utils
