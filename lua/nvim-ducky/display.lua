local display = {}
local nui = require("nui-components")
local nodes = require("nvim-ducky.nodes")
local node = require("nvim-ducky.node")

local renderer = nui.create_renderer({
	width = 20,
	height = 20,
	position = "100%",
})

function display:new(obj)
	print(table.unpack(nodes:render(obj.focus_node)))
	local body = function()
		return nui.columns(table.unpack(node:render(obj.focus_node)))
	end

	renderer:render(body)
	return obj
end

return display
