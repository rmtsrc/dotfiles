hs.hotkey.bind({"ctrl", "alt"}, "Right", windowGrowWidth)
hs.hotkey.bind({"ctrl", "alt"}, "Left", windowShrinkWidth)
hs.hotkey.bind({"ctrl", "alt"}, "Up", windowMoveAndResize("Top"))
hs.hotkey.bind({"ctrl", "alt"}, "Down", windowMoveAndResize("Bottom"))
hs.hotkey.bind({"ctrl", "alt"}, "home", windowMoveToDisplay(1))
hs.hotkey.bind({"ctrl", "alt"}, "end", windowMoveToDisplay(2))
