local wezterm = require("wezterm")

local is_linux = function()
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
	font_size = is_linux and 15 or 20,
	freetype_load_flags = "NO_HINTING",
	freetype_render_target = "HorizontalLcd",
	front_end = "OpenGL",
	initial_cols = 150,
	initial_rows = 40,
	macos_window_background_blur = 6,
	max_fps = 240,
	window_background_opacity = is_linux and 0.99 or 0.95,
	window_close_confirmation = "NeverPrompt",
	window_decorations = is_linux and "NONE" or "RESIZE",
	window_padding = {
		left = 10,
		right = 5,
		top = 10,
		-- bottom = "0.2cell",
		bottom = 1,
	},
}
