//
//  StatusMenuController.swift
//  SwiftUTCMenuClock
//
//  Created by Jonathan Thornton on 4/8/18.
//  Copyright © 2018 Jonathan Thornton. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
	/// The menu bar item which we'll be modifying and displaying.
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	
	@IBOutlet weak var menu: NSMenu!
    
    let calendar = Calendar.current
    let utc = TimeZone(identifier: "Etc/UTC")!
	
	override func awakeFromNib() {
		// Link the menu from MainMenu.xib to be displayed when someone clicks on the menu bar item.
		statusItem.menu = menu
        
        let showDateMenuItem = menu.item(withTitle: "Show Date")!
        if showDateSetting {
            showDateMenuItem.state = .on
        } else {
            showDateMenuItem.state = .off
        }
        
        let showSecondsMenuItem = menu.item(withTitle: "Show Seconds")!
        if showSecondsSetting {
            showSecondsMenuItem.state = .on
        } else {
            showSecondsMenuItem.state = .off
        }
        
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
    
    private func updateTimeString() {
        let now = Date(timeIntervalSinceNow: 0)
        let utcComponents = calendar.dateComponents(in: utc, from: now)
        var timeString = ""
        
        if showDateSetting {
            let year = String(describing: utcComponents.year!)
            let month = self.formatDateComponentInteger(utcComponents.month!)
            let day = self.formatDateComponentInteger(utcComponents.day!)
            timeString += "\(year)-\(month)-\(day) "
        }
        
        let hour = self.formatDateComponentInteger(utcComponents.hour!)
        let minute = self.formatDateComponentInteger(utcComponents.minute!)
        timeString += "\(hour):\(minute)"
        
        if showSecondsSetting {
            let second = self.formatDateComponentInteger(utcComponents.second!)
            timeString += ":\(second)"
        }
        
        timeString += " UTC"
        self.statusItem.button?.title = timeString
        var fontSize = CGFloat(14.0)
        if #available(macOS 11.0, *) {
            fontSize = CGFloat(13.0)
        }
        self.statusItem.button?.font = NSFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .regular)
    }
    
    private func formatDateComponentInteger(_ component: Int) -> String {
        if component < 10 {
            return "0\(component)"
        } else {
            return String(describing: component)
        }
    }
    
    let showSecondsKey = "showSeconds"
    private var showSecondsSetting: Bool { UserDefaults.standard.bool(forKey: showSecondsKey) }
    let showDateKey = "showDate"
    private var showDateSetting: Bool { UserDefaults.standard.bool(forKey: showDateKey) }
	
    @IBAction func showDateClicked(_ sender: Any) {
        let showDateMenuItem = menu.item(withTitle: "Show Date")!
        if showDateSetting {
            UserDefaults.standard.set(false, forKey: showDateKey)
            showDateMenuItem.state = .off
        } else {
            UserDefaults.standard.set(true, forKey: showDateKey)
            showDateMenuItem.state = .on
        }
        updateTimeString()
        menu.update()
    }
    
    @IBAction func showSecondsClicked(_ sender: Any) {
        let showSecondsMenuItem = menu.item(withTitle: "Show Seconds")!
        if showSecondsSetting {
            UserDefaults.standard.set(false, forKey: showSecondsKey)
            showSecondsMenuItem.state = .off
        } else {
            UserDefaults.standard.set(true, forKey: showSecondsKey)
            showSecondsMenuItem.state = .on
        }
        updateTimeString()
        menu.update()
    }
    
    @IBAction func quitClicked(_ sender: Any) {
		// Quit the application.
		NSApplication.shared.terminate(self)
	}
}
