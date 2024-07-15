local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	font_size = 18.5,
	initial_cols = 130,
	initial_rows = 33,
	max_fps = 240,
	window_background_opacity = 0.97,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_padding = {
		left = 15,
		right = 15,
		top = 10,
		bottom = 0,
	},
}
