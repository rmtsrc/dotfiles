require "functions"
require "barrier"

hs.hotkey.bind({"ctrl"}, "home", splitWindowLeft)
hs.hotkey.bind({"ctrl"}, "end", splitWindowRight)
hs.hotkey.bind({"ctrl"}, "pageup", maximizeWindow)
hs.hotkey.bind({"ctrl", "alt"}, "Right", growWindowWidth)
hs.hotkey.bind({"ctrl", "alt"}, "Left", shrinkWindowWidth)
hs.hotkey.bind({"ctrl", "alt"}, "Up", splitWindowTop)
hs.hotkey.bind({"ctrl", "alt"}, "Down", splitWindowBottom)
hs.hotkey.bind({"ctrl", "alt"}, "home", moveWindowToDisplay(1))
hs.hotkey.bind({"ctrl", "alt"}, "end", moveWindowToDisplay(2))
hs.hotkey.bind({"ctrl", "shift"}, "d", typeDate)
hs.hotkey.bind({"ctrl", "cmd"}, "w", systemSleep)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "forwarddelete", systemShutdown)
