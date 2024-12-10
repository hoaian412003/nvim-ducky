local display = {}
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("nvim-ducky.utils")
local ui = require("nvim-ducky.ui")

function display:new(obj)
	ui.highlight_setup(obj)

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
		win_options = {
			winhighlight = "Normal:NavbuddyNormalFloat,FloatBorder:NavbuddyFloatBorder",
		},
		buf_options = {
			modifiable = false,
		},
	})

	obj.popup = popup

	popup:mount()
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	local nodes = utils.get_node_list(obj.focus_node)

	for k, v in pairs(nodes) do
		vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", true)
		vim.api.nvim_buf_set_lines(popup.bufnr, k - 1, k, false, { obj.config.icons[v.kind] .. v.name })
		vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)
	end

	vim.api.nvim_buf_set_option(popup.bufnr, "winhighlight", "CursorLine:BufferLinePickSelected")

	return obj
end

return display
