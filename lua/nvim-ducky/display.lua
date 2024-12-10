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
			cursorline = true,
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

	for k, node in pairs(nodes) do
		local hl_group = "Navbuddy" .. navic.adapt_lsp_num_to_str(node.kind)
		vim.print("Highlight: ", hl_group)
		vim.api.nvim_buf_add_highlight(buffer, ns, hl_group, k - 1, 0, -1)
	end

	-- Write list of symbols to buffer
	vim.api.nvim_buf_set_option(buffer, "modifiable", true)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buffer, "modifiable", false)
end

function display:autocmd(buffer)
	local augroup = vim.api.nvim_create_augroup("Ducky", { clear = false })
	vim.api.nvim_clear_autocmds({ buffer = buffer })
end

return display
