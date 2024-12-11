local display = {}
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("nvim-ducky.utils")
local ui = require("nvim-ducky.ui")
local ns = vim.api.nvim_create_namespace("nvim-ducky")
local navic = require("nvim-navic.lib")

function display:new(obj)
	ui.highlight_setup(obj.config)

	local popup = Popup({
		enter = false,
		focusable = true,
		border = {
			style = "rounded",
		},
		position = {
			col = "100%",
			row = "10%",
		},
		size = {
			width = "20%",
			height = "50%",
		},
		win_options = {
			winhighlight = "Normal:NavbuddyNormalFloat,FloatBorder:NavbuddyFloatBorder",
			scrolloff = obj.config.window.scrolloff,
			cursorline = true,
		},
		buf_options = {
			modifiable = false,
		},
		relative = "editor",
	})

	popup:mount()

	obj.popup = popup
	display:fill_buffer(popup, obj.focus_node, obj.config)
	return obj
end

function display:fill_buffer(popup, current_node, config)
	local nodes = utils.get_node_list(current_node)
	local buffer = popup.bufnr
	local win = popup.winid

	if buffer == nil or win == nil then
		return
	end

	local lines = {}
	local length = 0
	for _, node in ipairs(nodes) do
		local text = " " .. config.icons[node.kind] .. node.name
		table.insert(lines, text)
		length = length + 1
	end

	-- Write list of symbols to buffer
	vim.api.nvim_buf_set_option(buffer, "modifiable", true)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buffer, "modifiable", false)

	for k, node in ipairs(nodes) do
		local hl_group = "Navbuddy" .. navic.adapt_lsp_num_to_str(node.kind)
		vim.api.nvim_buf_add_highlight(buffer, ns, hl_group, k - 1, 0, -1)
		if node.index == current_node.index then
			-- vim.print(win)
			vim.api.nvim_win_set_cursor(win, { k, 0 })
		end
	end
	popup:set_size({
		width = "20%",
		height = length,
	})
	popup.border:set_text("top", current_node.name, "center")
end

function display:refresh(current_node)
	display:fill_buffer(self.popup, current_node, self.config)
	self.focus_node = current_node
	return self
end

return display
