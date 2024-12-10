local utils = {}

-- lua print(require('nvim-ducky').utils.get_symbols())
function utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

function utils.get_node_list(current_node)
	if current_node == nil then
		return {}
	end
	vim.print(utils.get_node_next(current_node.next))

	return { unpack(utils.get_node_pre(current_node.prev)), current_node, utils.get_node_next(current_node.next) }
end

function utils.get_node_pre(current_node)
	if current_node == nil then
		return {}
	end
	local left = utils.get_node_pre(current_node.prev)
	return { unpack(left), current_node }
end

function utils.get_node_next(current_node)
	if current_node == nil then
		return {}
	end
	local right = utils.get_node_next(current_node.next)
	return { current_node, unpack(right) }
end

return utils
