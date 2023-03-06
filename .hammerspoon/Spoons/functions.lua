 function splitWindowLeft()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function splitWindowRight()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function splitWindowTop()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end

function splitWindowBottom()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end

function maximizeWindow()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end

function growWindowWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w + (max.w / 10)
  win:setFrame(f)
end

function shrinkWindowWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w - (max.w / 10)
  win:setFrame(f)
end

function moveWindowToDisplay(d)
  return function()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    win:moveToScreen(displays[d], false, true)
  end
end

function showHideMissionControl()
  hs.osascript.applescript('tell application "System Events" to key code 126 using {control down}')
end

function switchToWorkspaceLeft()
  hs.osascript.applescript('tell application "System Events" to key code 123 using {control down}')
end

function switchToWorkspaceRight()
  hs.osascript.applescript('tell application "System Events" to key code 124 using {control down}')
end

function systemSleep()
  hs.caffeinate.systemSleep()
end

function systemShutdown()
  hs.caffeinate.shutdownSystem()
end

function toggleDarkMode()
  hs.osascript.applescript('tell app "System Events" to tell appearance preferences to set dark mode to not dark mode')
end

function typeDate()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end

function setKeyboardLayoutBritish()
  hs.keycodes.setLayout("British")
  hs.execute("ln -sf ~/.hammerspoon/keyboard-built-in.lua ~/.hammerspoon/keyboard-current-extra.lua")
end

function setKeyboardLayoutBritishPC()
  hs.keycodes.setLayout("British – PC")
  hs.execute("ln -sf ~/.hammerspoon/keyboard-usb.lua ~/.hammerspoon/keyboard-current-extra.lua")
end
