local awful = require("awful")
local wibox = require("wibox")

battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

function battery_markup(cb)
  -- Use grep to disambiguate battery vs. USB hub by 'rate unformation unavalable'
  awful.spawn.easy_async_with_shell("acpi | grep -v 'rate information unavailable'", function(acpi)
    local charge = tonumber(string.match(acpi, "(%d+)%%"))

    local bg = ''
    if tonumber(charge) <= 20 then
      bg = 'red'
    end

    -- If charging or full, always show green.
    if string.match(acpi, "Discharging") == nil then
      bg = 'green'
    end

    if not (bg == '') then
      bg = string.format("background='%s'", bg)
    end

    cb(string.format("<span %s>BAT=%s%%</span>", bg, charge))
  end)
end

function update_battery(w)
  local cb = function(markup)
    if markup == nil then
      markup = string.format("<span background='red'>BAT N/A %s</span>", markup)
    end

    w:set_markup(markup)
  end

  battery_markup(cb)
end

update_battery(battery_widget)

local mytimer = timer({timeout = 1})
mytimer:connect_signal("timeout", function() update_battery(battery_widget) end)
mytimer:start()
