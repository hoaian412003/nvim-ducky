local actions = {}
local ducky = require("nvim-ducky")
local utils = require("nvim-ducky.utils")
local session = ducky.session

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
	local next = utils.find_next_node(session.current_node)

	actions.jump_to_node(next)
end

-- lua require('nvim-ducky.actions').jump_prev()
function actions.jump_prev()
	local prev = utils.find_prev_node(session.current_node)

	actions.jump_to_node(prev)
end

return actions
