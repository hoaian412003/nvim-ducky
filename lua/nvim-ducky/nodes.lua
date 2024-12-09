local node = require("nvim-ducky.node")
local nodes = {}

function nodes:render(current_node)
	local result = {}
	while current_node ~= nil do
		result[tonumber(current_node.index)] = node:render(current_node)
		current_node = current_node.next
	end

	return result
end

return nodes
