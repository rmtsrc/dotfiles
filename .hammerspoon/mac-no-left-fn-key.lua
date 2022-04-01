require "functions"
require "barrier"

hs.hotkey.bind({"ctrl", "alt"}, "Left", splitWindowLeft)
hs.hotkey.bind({"ctrl", "alt"}, "Right", splitWindowRight)
hs.hotkey.bind({"ctrl", "alt"}, "Up", maximizeWindow)
hs.hotkey.bind({"alt", "cmd"}, "Right", growWindowWidth)
hs.hotkey.bind({"alt", "cmd"}, "Left", shrinkWindowWidth)
hs.hotkey.bind({"alt", "cmd"}, "Up", splitWindowTop)
hs.hotkey.bind({"alt", "cmd"}, "Down", splitWindowBottom)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Right", moveWindowToDisplay(1))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left", moveWindowToDisplay(2))
hs.hotkey.bind({"ctrl", "shift"}, "d", typeDate)
hs.hotkey.bind({"ctrl", "cmd"}, "w", systemSleep)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "forwarddelete", systemShutdown)
