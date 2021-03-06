local u = {}

function u.pread(cmd)
  local fd = io.popen(cmd)
  local read = fd:read("*all")
  fd:close()
  return read
end

function u.timed_widget(cb, timeout)
  cb()

  if timeout == nil then
    timeout = 1
  end

  local t = timer({ timeout = timeout })
  t:connect_signal("timeout", cb)
  t:start()
end


return u
