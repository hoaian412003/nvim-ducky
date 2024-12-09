local display = {}
local nui = require("nui-components")
local nodes = require("nvim-ducky.nodes")

local renderer = nui.create_renderer({
	width = 20,
	height = 20,
	position = {
		row = "0%",
		col = "100%",
	},
})

function display:new(obj)
	print(table.unpack(nodes:render(obj.focus_node)))
	local body = function()
		return nui.columns(table.unpack(nodes:render(obj.focus_node)))
	end

	renderer:render(body)
	obj.ui = renderer
	renderer:focus()
	return obj
end

return display
