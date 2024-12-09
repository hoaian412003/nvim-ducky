local display = {}
local n = require("nui-components")

local renderer = n.create_renderer({
	width = 80,
	height = 40,
})

function display:new(obj)
	vim.print(obj.focus_node)

	renderer:renderer(n.paragraph({
		lines = "nui.components",
		align = "center",
		is_focusable = false,
	}))
end

return display
