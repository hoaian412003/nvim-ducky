local display = {}
local n = require("nui-components")

local renderer = n.create_renderer({
	width = 10,
	height = 20,
})

function display:new(obj)
	vim.print(obj.focus_node)

	local body = function()
		return n.rows(
			n.columns(
				{ flex = 0 },
				n.text_input({
					autofocus = true,
					flex = 1,
					max_lines = 1,
				}),
				n.gap(1),
				n.button({
					label = "Send",
					padding = {
						top = 1,
					},
				})
			),
			n.paragraph({
				lines = "nui.components",
				align = "center",
				is_focusable = false,
			})
		)
	end

	renderer:render(body)
end

return display
