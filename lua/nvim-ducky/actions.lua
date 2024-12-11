local actions = {}
local ducky = require("nvim-ducky")
local utils = require("nvim-ducky.utils")
local session = ducky.session

function actions.ensure_loaded()
	if session.current_node == nil then
		ducky.open()
	end
end

function actions.jump_to_node(node)
	if node == nil then
		return
	end
	local win = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_cursor(win, {
		node.name_range.start.line,
		node.name_range.start.character,
	})
end

-- lua require('nvim-ducky.actions').jump_next()
function actions.jump_next()
	actions.ensure_loaded()
	local next = utils.find_next_node(session.current_node)

	actions.jump_to_node(next)
end

-- lua require('nvim-ducky.actions').jump_prev()
function actions.jump_prev()
	actions.ensure_loaded()
	local prev = utils.find_prev_node(session.current_node)

	actions.jump_to_node(prev)
end

function actions.hide()
	if session.display ~= nil then
		session.display.popup:hide()
	end
end

return actions
