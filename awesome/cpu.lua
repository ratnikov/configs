local wibox = require("wibox")
cpu_widget = wibox.widget.textbox()
cpu_widget:set_align("right")

function cpu_usage()
	local iostat = io.popen("iostat -c | head -n 4 | tail -n 1"):read("*all")

	local user, nice, system, iowait, steal, idle = string.match(iostat, "(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)")

	return (user + nice + system + iowait + steal), idle
end

function update_cpu(w)
	local cpu, idle = cpu_usage()

	local m = string.format("<span %s>CPU=%sI%s</span>", background(cpu, 50, 90), cpu, idle)
	w:set_markup(m)
end

function background(val, yellow, red)
	local bg = ''
	if tonumber(val) > yellow then
		bg = 'yellow'
	end

	if tonumber(val) > red then
		bg = 'red'
	end

	if not (bg == '') then
		bg = string.format("background='%s'", bg)
	end

	return bg
end

update_cpu(cpu_widget)

local mytimer = timer({timeout = 1})
mytimer:connect_signal("timeout", function() update_cpu(cpu_widget) end)
mytimer:start()

