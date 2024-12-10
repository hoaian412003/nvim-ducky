local utils = {}

-- lua print(require('nvim-ducky').utils.get_symbols())
function utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

function utils.get_node_list(current_node)
	local index = 1
	local result = {}
	while current_node ~= nil do
		result[index] = current_node
		index = index + 1
		current_node = current_node.next
	end
	return result
end

return utils
