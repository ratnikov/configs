local wibox = require("wibox")
local awful = require("awful")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

function update_volume_num(widget)
  awful.spawn.easy_async_with_shell("amixer sget Master", function(status)
    -- local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)

    status = string.match(status, "%[(o[^%]]*)%]")

    if string.find(status, "on", 1, true) then
      -- For the volume numbers
      volume = volume .. "%"
    else
      -- For the mute button
      volume = volume .. "M"

    end
    widget:set_markup("VOL=" .. volume)
  end)
end

update_volume_num(volume_widget)

mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_volume_num(volume_widget) end)
mytimer:start()
