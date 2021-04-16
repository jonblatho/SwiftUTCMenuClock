import Cocoa
import ServiceManagement

extension Notification.Name {
    static let killLauncher = Notification.Name("killMenuClockLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
        if !Settings.hasRunBefore.isEnabled {
            Settings.hasRunBefore.enable()
            Settings.openAtLogin.enable()
        }
        
        let launcherAppID = "com.jonblatho.MenuClockLauncher"
        let runningApps = NSWorkspace.shared.runningApplications
        let launcherIsRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppID }.isEmpty
        
        SMLoginItemSetEnabled(launcherAppID as CFString, true)
        
        if launcherIsRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
        }
	}
}

