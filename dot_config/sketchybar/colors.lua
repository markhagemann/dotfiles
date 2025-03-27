return {
	black = 0xff1b1d2b,
	-- white = 0xffe2e2e3,
	white = 0xffafafb3,
	red = 0xfffc5d7c,
	green = 0xff9ed072,
	blue = 0xff76cce0,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xff82aaff,
	grey = 0xff7f8490,
	transparent = 0x00000000,

	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	-- bg1 = 0xff363944,
	bg1 = 0xff222436,
	-- bg2 = 0xff414550,
	bg2 = 0xff1e2030,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
