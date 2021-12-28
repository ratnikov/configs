local spawn = require("awful").spawn;
local wibox = require("wibox")
local util = require("util")

function check_monitor(device)
  local xrandr = util.pread(string.format("xrandr | grep ^%s", device))

  if string.match(xrandr, "disconnected") then
    local cmd = string.format("xrandr --output %s --off", device)
    fd = io.popen(cmd)
    fd:close()

    return false
  else
    local cmd = string.format(
      "xrandr --output eDP-1 --primary --mode 1920x1080 --right-of %s --rotate normal --output %s --auto --pos 0x0 --rotate normal",
      device, device)
    fd = io.popen(cmd)
    fd:close()

    return true
  end
end

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
