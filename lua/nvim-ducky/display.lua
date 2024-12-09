local display = {}

function display:new(obj)
	vim.print(obj.focus_node)
end

return display
