local node = require("nvim-ducky.node")
local nodes = {}

function nodes:render(current_node)
	local result = {}
	local index = 1
	while current_node ~= nil do
		result[index] = node:render(current_node)
		current_node = current_node.next
		index = index + 1
	end

	return result
end

return nodes
