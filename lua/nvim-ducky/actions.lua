local actions = {}
local ducky = require("nvim-ducky")
local session = ducky.session

function actions.jump_to_node(node)
	local win = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_cursor(win, {
		node.name_range.start.line,
		node.name_range.start.character,
	})
end

-- lua require('nvim-ducky.actions').jump_next()
function actions.jump_next()
	actions.jump_to_node(session.current_node.next)
end

return actions
