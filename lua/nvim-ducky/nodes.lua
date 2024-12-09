local node = require("nvim-ducky.node")
local nodes = {}

function nodes:render(current_node)
	local result = {}
	vim.print("Current node is: ", current_node)
	while current_node ~= nil do
		vim.print(current_node.index, current_node)
		result[current_node.index] = node:render(current_node)
		current_node = current_node.next
	end

	return result
end

return nodes
