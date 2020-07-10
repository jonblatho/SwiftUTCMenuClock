# SwiftUTCMenuClock
A simple menu bar app for macOS that shows the current time in UTC. Loosely inspired by [UTCMenuClock](https://github.com/netik/UTCMenuClock) but rewritten from scratch in Swift 4 and, for now at least, missing a whole bunch of features from the original.

## Installation
Installing SwiftUTCMenuClock is super-easy *unless* you want it to run itself at login (see below).

1. Head to the [latest release](https://github.com/jonblatho/SwiftUTCMenuClock/releases/latest) and download **SwiftUTCMenuClock.app.zip**.
2. Drag **SwiftUTCMenuClock.app** from wherever it downloaded to to your Applications folder.
3. Open it!

### Adding a Login Item
You probably want this to run itself at login, don't you?! Well, here's how to do that.

1. Open System Preferences.
2. Go to **Users & Groups** and select yourself.
3. Go to the **Login Items** tab.
4. Click **+** below the list.
5. Find and select **SwiftUTCMenuClock.app** in Finder. (If you followed the installation steps above, it should be in your /Applications folder.)
6. You made it! SwiftUTCMenuClock should now run at login.

## License
This is released under the MIT License, which basically means that you can do whatever the heck you want with this as long as you credit me if you make any derivatives and you don't sue me if it forces your computer to combust or something like that. See the LICENSE file for details. Enjoy!

## Release history
### Version 1.0.1
Released 3 June 2018

* Resolved an issue that caused the application to use excessive energy.

### Version 1.0
Released 10 April 2018

* Initial release.
