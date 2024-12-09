local display = {}
local nui = require("nui-components")
local nodes = require("nvim-ducky.nodes")

local renderer = nui.create_renderer({
	width = 10,
	height = 20,
})

function display:new(obj)
	local body = function()
		return nui.columns(table.unpack(nodes:render(obj.focus_node)))
	end

	renderer:render(body)
	return obj
end

return display
