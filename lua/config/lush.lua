local lush = require("lush")
local hsl = lush.hsl

local theme = lush(function()
	return {
		Normal({
			bg = "black",
		}),
	}
end)

return theme
