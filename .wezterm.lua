local wezterm = require("wezterm")

return {
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "tokyonight_moon",
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "SpaceMono Nerd Font", harfbuzz_features = { "calt=0" } },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	font_size = 18,
	initial_cols = 130,
	initial_rows = 33,
	macos_window_background_blur = 10,
	max_fps = 240,
	window_background_opacity = 0.93,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_padding = {
		left = 15,
		right = 15,
		top = 10,
		bottom = 0,
	},
}
