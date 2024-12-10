local display = {}
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("nvim-ducky.utils")
local ui = require("nvim-ducky.ui")
local ns = vim.api.nvim_create_namespace("nvim-ducky")

function display:new(obj)
	ui.highlight_setup(obj.config)

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
			scrolloff = obj.config.window.scrolloff,
		},
		buf_options = {
			modifiable = false,
		},
	})

	obj.popup = popup

	display:fill_buffer(popup.bufnr, obj.focus_node, obj.config)

	popup:mount()
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	return obj
end

function display:fill_buffer(buffer, current_node, config)
	local nodes = utils.get_node_list(current_node)

	local lines = {}
	for _, node in ipairs(nodes) do
		local text = " " .. config.icons[node.kind] .. node.name
		table.insert(lines, text)
	end

	-- Write list of symbols to buffer
	vim.api.nvim_buf_set_option(buffer, "modifiable", true)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buffer, "modifiable", false)

	display:highlight_current_line(buffer, 1)
end

function display:highlight_current_line(buffer, line)
	vim.api.nvim_buf_add_highlight(buffer, ns, "CursorLine", line, 0, -1)
end

return display
