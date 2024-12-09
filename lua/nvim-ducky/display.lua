local display = {}
local nui = require("nui-components")
local nodes = require("nvim-ducky.nodes")
local node = require("nvim-ducky.node")

local renderer = nui.create_renderer({
	width = 10,
	height = 20,
})

function display:new(obj)
	print(table.unpack(nodes:render(obj.focus_node)))
	local body = function()
		return nui.columns(nui.rows(n.paragraph({
			lines = obj.focus_node.name,
			align = "center",
			is_focusable = false,
		})))
	end

	renderer:render(body)
	return obj
end

return display
