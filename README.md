# SwiftUTCMenuClock
A simple menu bar app for macOS that shows the current time in UTC. Loosely inspired by [UTCMenuClock](https://github.com/netik/UTCMenuClock) but rewritten from scratch in Swift.

Requires macOS Catalina or Big Sur.

## Installation
Installing SwiftUTCMenuClock is super-easy *unless* you want it to run itself at login (see below).

1. Head to the [latest release](https://github.com/jonblatho/SwiftUTCMenuClock/releases/latest) and download **SwiftUTCMenuClock.app.zip**.
2. Drag **SwiftUTCMenuClock.app** from wherever it downloaded to to your Applications folder.
3. Open it!

### Adding a Login Item
If you want this to open itself at login, here's how:

1. Open System Preferences.
2. Go to **Users & Groups** and select yourself.
3. Go to the **Login Items** tab.
4. Click **+** below the list.
5. Find and select **SwiftUTCMenuClock.app** in Finder. (If you followed the installation steps above, it should be in your /Applications folder.)
6. You made it! SwiftUTCMenuClock should now run at login.
