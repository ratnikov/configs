local spawn = require("awful").spawn;
local wibox = require("wibox")

function callback()
  local known_devices = "HDMI-1 DP-1 DP-2"
  spawn.easy_async_with_shell("2>/dev/null .config/awesome/configure_monitors.sh " .. known_devices, function(configured)
    monitor_widget:set_markup("<span>M=" .. configured .. "</span>")
  end)
end

monitor_widget = wibox.widget.textbox()
monitor_widget:set_align("right")

callback()

mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", callback)
mytimer:start()
