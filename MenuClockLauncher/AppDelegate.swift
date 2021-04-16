import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("killMenuClockLauncher")
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @objc func terminate() {
        NSApplication.shared.terminate(self)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppID = "com.jonblatho.SwiftUTCMenuClock"
        let runningApps = NSWorkspace.shared.runningApplications
        let mainAppIsRunning = !runningApps.filter { $0.bundleIdentifier == mainAppID }.isEmpty
        
        if !mainAppIsRunning && Settings.openAtLogin.isEnabled {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppID)
            
            if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: mainAppID) {
                let configuration = NSWorkspace.OpenConfiguration()
                NSWorkspace.shared.openApplication(at: url, configuration: configuration, completionHandler: nil)
            }            
        } else {
            self.terminate()
        }
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

