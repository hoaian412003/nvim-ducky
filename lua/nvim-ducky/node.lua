local node = {}
local nui = require("nui-components")

function node:render(current_node)
	-- return nui.rows(nui.text(current_node.name))
	return current_node.name
end

return node
