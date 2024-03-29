#!/usr/bin/env bash

# Source: https://invent.kde.org/thiagosueto/kdialogscripts/-/blob/master/meta-overview.bash

kdialog --yesno "Would you like to set Overview to open with Meta?\nYes enables it, No or closing this window disables it." --title "Overview as meta"
ISMETA=$?

reconfigureKWin () {
    if [ -x "$(command -v qdbus)" ]
    then
        qdbus org.kde.KWin /KWin reconfigure
    elif [ -x "$(command -v qdbus-qt5)" ]
    then
        qdbus-qt5 org.kde.KWin /KWin reconfigure
    elif [ -x "$(command -v qdbus6)" ]
    then
        qdbus6 org.kde.KWin /KWin reconfigure
    else
        kdialog --error "You don't have any qdbus utility!\nThe changes were written to the configuration file, but were NOT applied automatically.\nIt should work once you log out."
        exit 1
    fi
}

if [ "$ISMETA" == 0 ]
then
    kwriteconfig"${KDE_SESSION_VERSION}" --file kglobalshortcutsrc --group kwin --key Overview "Meta+W,Meta+W,Toggle Overview";
    kwriteconfig"${KDE_SESSION_VERSION}" --file kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.kglobalaccel,/component/kwin,,invokeShortcut,Overview";
    kwriteconfig"${KDE_SESSION_VERSION}" --file kwinrc --group Plugins --key overviewEnabled "true";
    reconfigureKWin

else
    # This will disable the Overview, you will need to manually enable the effect again
    # or use this script.
    kwriteconfig"${KDE_SESSION_VERSION}" --file kglobalshortcutsrc --group kwin --key Overview --delete;
    kwriteconfig"${KDE_SESSION_VERSION}" --file kwinrc --group Plugins --key overviewEnabled --delete;
    kwriteconfig"${KDE_SESSION_VERSION}" --file kwinrc --group ModifierOnlyShortcuts --key Meta --delete;
    reconfigureKWin
fi
