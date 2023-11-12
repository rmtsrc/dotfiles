local usbWatcher = nil

function usbDeviceCallback(data)
  -- local log = hs.logger.new("usbDeviceCallback", "debug")
  -- log.i(data["productName"], data["eventType"], hs.keycodes.currentLayout())
  if (data["productName"] == "Keychron K3") then
    if (data["eventType"] == "added") then
      setKeyboardLayoutBritishPC()
    elseif (data["eventType"] == "removed") then
      setKeyboardLayoutBritish()
    end
  end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
