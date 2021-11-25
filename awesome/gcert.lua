local awful = require("awful")
local wibox = require("wibox")
local util = require("util")

local w = wibox.widget.textbox()
w:set_align("right")

util.timed_widget(function()
  awful.spawn.easy_async_with_shell("nice -n 10 gcertstatus 2>&1", function(status)
    if string.match(status, "file does not exist") or string.match(status, "expired") then
      w:set_markup("<span color='red'>NO CERT</span>")
    else
      w:set_markup("")
    end
  end)
end, 10) -- Check every 10s to avoid too much spam.

return w
