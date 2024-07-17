local wezterm = require("wezterm")

return {
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "tokyonight_moon",
	enable_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "SpaceMono Nerd Font", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
		{ family = "ZedMono Nerd Font", weight = "Medium" },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	font_size = 18,
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
