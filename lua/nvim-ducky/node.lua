local node = {}
local nui = require("nui-components")

function node:render(current_node)
	return nui.rows(nui.paragraph({ lines = current_node.name, autofocus = true }))
end

return node
