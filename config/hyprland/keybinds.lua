hl.bind(MODIFIER .. " + T", hl.dsp.exec_cmd(TERMINAL))
hl.bind(MODIFIER .. " + W", hl.dsp.exec_cmd(BROWSER))
hl.bind(MODIFIER .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(MODIFIER .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(MODIFIER .. " + MINUS", hl.dsp.layout("colresize -0.1"))
hl.bind(MODIFIER .. " + EQUAL", hl.dsp.layout("colresize +0.1"))
hl.bind(MODIFIER .. " + CTRL + SPACE", hl.dsp.window.float())
hl.bind(MODIFIER .. " + P", hl.dsp.window.pin())

hl.bind(MODIFIER .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- ALT + LMB: Move a window by dragging more than 10px.
hl.bind(MODIFIER .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true }) -- ALT + LMB: Floats a window by clicking

for direction, key in pairs({ ["left"] = "H", ["right"] = "L", ["up"] = "K", ["down"] = "J" }) do
	hl.bind(MODIFIER .. " + " .. direction, hl.dsp.focus({ direction = direction }))
	hl.bind(MODIFIER .. " + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind(MODIFIER .. " + CTRL + " .. direction, hl.dsp.window.swap({ direction = direction }))
	hl.bind(MODIFIER .. " + CTRL + " .. key, hl.dsp.window.swap({ direction = direction }))
end

hl.bind(MODIFIER .. " + BRACKETLEFT", hl.dsp.layout("consume_or_expel prev"))
hl.bind(MODIFIER .. " + BRACKETRIGHT", hl.dsp.layout("consume_or_expel next"))

hl.bind(MODIFIER .. " + SHIFT + E", hl.dsp.exec_cmd("hyprshutdown"))

for i = 1, 10, 1 do
	hl.bind(MODIFIER .. " + " .. i % 10, hl.dsp.focus({ workspace = i }))
	hl.bind(MODIFIER .. " + SHIFT + " .. i % 10, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + F4", hl.dsp.window.close())

hl.bind(MODIFIER .. " + SHIFT + S", hl.dsp.exec_raw('grim -g "$(slurp)" - | swappy -f -  '))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ +5%"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%"), { locked = true })

hl.bind(MODIFIER .. " + D", hl.dsp.workspace.toggle_special("beeper"))
hl.workspace_rule({
	workspace = "special:beeper",
	on_created_empty = "beeper",
})
hl.window_rule({
	name = "Beeper workspace",
	match = {
		class = "^Beeper$",
		title = "^Beeper$",
		initial_class = "^Beeper$",
		initial_title = "^Beeper$",
	},
	workspace = "special:beeper",
})

hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.workspace.toggle_special("btop"))
hl.workspace_rule({
	workspace = "special:btop",
	on_created_empty = "alacritty --class btop -e btop",
})
