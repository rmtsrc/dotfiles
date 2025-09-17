function windowMoveAndResize(direction)
  return function()
    local app = hs.application.frontmostApplication()
    app:selectMenuItem({"Window", "Move & Resize", direction})
  end
end

function windowFill()
  local app = hs.application.frontmostApplication()
  app:selectMenuItem({"Window", "Fill"})
end

function windowGrowWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w + (max.w / 10)
  win:setFrame(f)
end

function windowShrinkWidth()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = f.w - (max.w / 10)
  win:setFrame(f)
end

function windowMoveToDisplay(d)
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

function showClipboard()
  -- Press Cmd + Space (open Spotlight)
  hs.eventtap.keyStroke({"cmd"}, "space", 0)

  -- Slight delay before pressing Cmd + 4
  hs.timer.doAfter(0.2, function()
    hs.eventtap.keyStroke({"cmd"}, "4", 0)
  end)
end

function setKeyboardLayoutBritish()
  hs.execute("ln -sf ~/.hammerspoon/keyboard-with-fn.lua ~/.hammerspoon/keyboard-current-extra.lua")
  hs.reload()
  hs.keycodes.setLayout("British")
end

hs.urlevent.bind("setKeyboardLayoutBritishPC", function(eventName, params)
  setKeyboardLayoutBritishPC()
end)

function setKeyboardLayoutBritishPC()
  hs.execute("ln -sf ~/.hammerspoon/keyboard-without-fn.lua ~/.hammerspoon/keyboard-current-extra.lua")
  hs.reload()
  hs.keycodes.setLayout("British – PC")
end

hs.urlevent.bind("setKeyboardLayoutBritish", function(eventName, params)
  setKeyboardLayoutBritish()
end)
