local wezterm = require("wezterm")

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

return {
	audible_bell = "Disabled",
	cell_width = 0.9,
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "tokyonight_moon",
	enable_tab_bar = false,
	enable_wayland = false,
	font = wezterm.font_with_fallback({
		{ family = "OverpassM Nerd Font", weight = 600 },
		{ family = "SpaceMono Nerd Font", harfbuzz_features = { "calt=0" } },
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	dpi = 96,
	dpi_by_screen = {
		["Built-in Retina Display"] = 144,
	},
	font_size = 20,
	freetype_load_flags = "NO_HINTING",
	freetype_render_target = "HorizontalLcd",
	front_end = "OpenGL",
	initial_cols = 150,
	initial_rows = 40,
	macos_window_background_blur = 6,
	max_fps = 240,
	window_background_opacity = is_darwin and 0.95 or 0.99,
	window_close_confirmation = "NeverPrompt",
	window_decorations = is_darwin and "RESIZE" or "NONE",
	window_padding = {
		left = 10,
		right = 5,
		top = 10,
		-- bottom = "0.2cell",
		bottom = 1,
	},
}
