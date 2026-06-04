hl.config({ general = { layout = "scrolling" } })
hl.config({
	general = {
		gaps_out = 10,
		gaps_in = 5,
		border_size = 5,
		col = {
			active_border = "rgb(7fc8ff)",
			inactive_border = "rgba(595959aa)",
		},
	},
	decoration = {
		rounding = 12,
	},
})
hl.config({
	input = {
		touchpad = {
			natural_scroll = true,
		},
		kb_layout = KEYBOARD_LAYOUT,
	},
})
hl.config({ scrolling = {
	direction = "right",
} })

hl.window_rule({
	name = "firefox width",
	match = {
		initial_class = "^librewolf$",
		initial_title = "^LibreWolf$",
	},
	scrolling_width = 1,
})

hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1 }, { 0.1, 1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })

hl.animation({ leaf = "workspaces", enabled = true, style = "slidevert", speed = 5, bezier = "wind" })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut" })
--hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "wind" })

hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
--hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
