local wibox = require("wibox")
local spawn = require("awful").spawn

cpu_widget = wibox.widget.textbox()
cpu_widget:set_align("right")

function update_cpu(w)
  spawn.easy_async_with_shell("iostat -c | head -n 4 | tail -n 1", function(iostat)
    local user, nice, system, iowait, steal, idle = string.match(iostat, "(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)")
    local cpu = user + nice + system + iowait + steal

    local m = string.format("<span %s>CPU=%sI%s</span>", background(cpu, 50, 90), cpu, idle)
    w:set_markup(m)
  end)
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

