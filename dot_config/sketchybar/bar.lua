local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 40,
	color = colors.with_alpha(colors.bg1, 0.8),
	padding_right = 4,
	padding_left = 4,
})
