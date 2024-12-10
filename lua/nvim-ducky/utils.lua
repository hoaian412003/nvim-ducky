local utils = {}

-- lua print(require('nvim-ducky').utils.get_symbols())
function utils.get_symbols()
	return vim.lsp.buf.document_symbol()
end

function utils.get_node_list(current_node)
	if current_node == nil then
		return {}
	end
	-- vim.print(utils.get_node_next(current_node.next))
	--
	local result = {}

	table.merge(utils.get_node_pre(current_node.prev), utils.get_node_next(current_node), result)

	return table
end

function utils.get_node_pre(current_node)
	if current_node == nil then
		return {}
	end
	local left = utils.get_node_pre(current_node.prev)
	table.insert(left, current_node)
	return left
end

function utils.get_node_next(current_node)
	if current_node == nil then
		return {}
	end
	local right = utils.get_node_next(current_node.next)
	table.insert(right, 1, current_node)
	return right
end

function table.merge(table1, table2, result)
	for _, v in ipairs(table1) do
		table.insert(result, v)
	end
	for _, v in ipairs(table2) do
		table.insert(result, v)
	end
end

return utils
