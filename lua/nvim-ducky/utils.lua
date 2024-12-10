local utils = {}

-- lua print(require('nvim-ducky').utils.get_symbols())
function utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

function utils.get_node_list(current_node)
	vim.print("current node is: " .. current_node.name)
	if current_node == nil then
		return nil
	end
	local result = { current_node }
	local left = utils.get_node_list(current_node.prev)
	local right = utils.get_node_list(current_node.next)

	if left ~= nil then
		result = { unpack(left), unpack(result) }
	end
	if right ~= nil then
		result = { unpack(result), unpack(right) }
	end

	return result
end

return utils
