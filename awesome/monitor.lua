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
      "xrandr --output eDP-1 --primary --mode 1920x1080 --pos 824x2160 --rotate normal --output %s --auto --pos 0x0 --rotate normal",
      device)
    fd = io.popen(cmd)
    fd:close()

    return true
  end
end

function callback()
  local txt = "OFF"

  -- Iterate over all the known non-primary monitor options and see if any of them are connected.
  -- If they are, connect it.
  --
  -- Only pick the first one since positioning of multiple extra displays isn't designed for.
  for i, device in ipairs({ "HDMI-1", "DP-1", "DP-2"}) do
    local status = check_monitor(device)

    if status then
      txt = device

      -- check_monitor isn't designed to juggle more than 1 extra displays, so stop after we found
      -- the first one.
      break
    end
  end

  monitor_widget:set_markup("<span>M=" .. txt .. "</span>")
end

monitor_widget = wibox.widget.textbox()
monitor_widget:set_align("right")

callback()

mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", callback)
mytimer:start()
