local display = {}
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("nvim-ducky.utils")

function display:new(obj)
	local popup = Popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
		},
		position = "100%",
		size = {
			width = "20%",
			height = "50%",
		},
	})

	obj.popup = popup

	popup:mount()
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	local nodes = utils.get_node_list(obj.focus_node)

	for k, v in pairs(nodes) do
		vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { v.name })
	end

	return obj
end

return display
