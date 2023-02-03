local usbWatcher = nil

function usbDeviceCallback(data)
  -- local log = hs.logger.new("usbDeviceCallback", "debug")
  -- log.i(data["productName"], data["eventType"], hs.keycodes.currentLayout())
  if (data["productName"] == "Keychron K3") then
    if (data["eventType"] == "added") then
      hs.keycodes.setLayout("British – PC")
      hs.execute("ln -sf ~/.hammerspoon/keyboard-usb.lua ~/.hammerspoon/keyboard-current-extra.lua")
    elseif (data["eventType"] == "removed") then
      hs.keycodes.setLayout("British")
      hs.execute("ln -sf ~/.hammerspoon/keyboard-built-in.lua ~/.hammerspoon/keyboard-current-extra.lua")
    end
    hs.reload()
  end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
