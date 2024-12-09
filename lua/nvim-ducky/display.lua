local display = {}
local nui = require("nui-components")
local nodes = require("nvim-ducky.nodes")

local renderer = nui.create_renderer({
	width = 10,
	height = 20,
})

function display:new(obj)
	-- vim.print("Node Array", nodes:render(obj.focus_node))
	vim.print(table.unpack(nodes:render(obj.focus_node)), "---> Node list")
	vim.print(nodes:render(obj.focus_node), "---> Node table")
	local body = nui.columns(unpack(nodes:render(obj.focus_node)))
	-- vim.print(obj.focus_node)

	renderer:render(body)
	return obj
end

return display
