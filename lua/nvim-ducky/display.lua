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
		position = {
			col = "100%",
			row = "0%",
		},
		size = {
			width = "20%",
			height = "50%",
		},
		highlight = "Normal:NotifyBackground",
	})

	obj.popup = popup

	popup:mount()
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	local nodes = utils.get_node_list(obj.focus_node)

	for k, v in pairs(nodes) do
		vim.api.nvim_buf_set_lines(popup.bufnr, k - 1, k, false, { v.name })
	end

	return obj
end

return display
