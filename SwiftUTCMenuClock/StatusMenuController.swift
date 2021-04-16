import Cocoa
import Time

internal final class StatusMenuController: NSObject {
	
	@IBOutlet weak var menu: NSMenu!
	
	override internal func awakeFromNib() {
		// Link the menu from MainMenu.xib to be displayed when someone clicks on the menu bar item.
		statusItem.menu = menu
        
        let showDayOfWeekMenuItem = menu.item(withTitle: "Show Day of Week")!
        showDayOfWeekMenuItem.state = Settings.showDayOfWeek.menuItemState
        
        let showDateMenuItem = menu.item(withTitle: "Show Date")!
        showDateMenuItem.state = Settings.showDate.menuItemState
        
        let showSecondsMenuItem = menu.item(withTitle: "Show Seconds")!
        showSecondsMenuItem.state = Settings.showSeconds.menuItemState
        
        let flashTimeSeparatorsMenuItem = menu.item(withTitle: "Flash Time Separators")!
        flashTimeSeparatorsMenuItem.state = Settings.flashTimeSeparators.menuItemState
        
        let openAtLoginMenuItem = menu.item(withTitle: "Open at Login")!
        openAtLoginMenuItem.state = Settings.openAtLogin.menuItemState
        
        updateTimeString()
		
		// Set up a timer running every 0.02 seconds that gets the current time and formats it, if needed, for the menu bar.
		Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
			let now = Date(timeIntervalSinceNow: 0)
			// Check the current centisecond to see if we actually need to update the time string.
            let centisecond = self.calendar.component(.nanosecond, from: now) / 10000000
            if 0 <= centisecond && centisecond <= 3 {
                // We've got a second on the second (approximately). The time needs an update.
                self.updateTimeString()
            }
		}
	}
	
    @IBAction func flashTimeSeparatorsClicked(_ sender: Any) {
        let menuItem = menu.item(withTitle: "Flash Time Separators")!
        Settings.flashTimeSeparators.toggle(menuItem: menuItem)
        updateTimeString()
    }
    
    @IBAction func showDateClicked(_ sender: Any) {
        let menuItem = menu.item(withTitle: "Show Date")!
        Settings.showDate.toggle(menuItem: menuItem)
        updateTimeString()
    }
    
    @IBAction func showDayOfWeekClicked(_ sender: Any) {
        let menuItem = menu.item(withTitle: "Show Day of Week")!
        Settings.showDayOfWeek.toggle(menuItem: menuItem)
        updateTimeString()
    }
    
    @IBAction func showSecondsClicked(_ sender: Any) {
        let menuItem = menu.item(withTitle: "Show Seconds")!
        Settings.showSeconds.toggle(menuItem: menuItem)
        updateTimeString()
    }
    
    @IBAction func openAtLoginClicked(_ sender: Any) {
        let menuItem = menu.item(withTitle: "Open at Login")
        Settings.openAtLogin.toggle(menuItem: menuItem)
        menu.update()
    }
    
    @IBAction func quitClicked(_ sender: Any) {
		// Quit the application.
		NSApplication.shared.terminate(self)
	}
    
    // MARK: - Private
    
    /// The menu bar item which we'll be modifying and displaying.
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    private let calendar = Calendar.current
    
    private func updateTimeString() {
        var components: [Time.Components] = []
        if Settings.showDayOfWeek.isEnabled {
            components.append(.dayOfWeek)
        }
        if Settings.showDate.isEnabled {
            components.append(.monthAndDay)
        }
        if Settings.showSeconds.isEnabled {
            components.append(.seconds)
        }
        let timeString = Time.formattedDateAndTime(components: components, flashTimeSeparators: Settings.flashTimeSeparators.isEnabled)
        self.statusItem.button?.title = timeString + " UTC"
        var fontSize = CGFloat(14.0)
        if #available(macOS 11.0, *) {
            fontSize = CGFloat(13.0)
        }
        self.statusItem.button?.font = NSFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .regular)
    }
}
