local wezterm = require("wezterm")

return {
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "tokyonight_moon",
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "SpaceMono Nerd Font", harfbuzz_features = { "calt=0" } },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	dpi = 96,
	font_size = 14,
	initial_cols = 150,
	initial_rows = 40,
	macos_window_background_blur = 6,
	max_fps = 240,
	window_background_opacity = 0.95,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = "0.3cell",
	},
}
