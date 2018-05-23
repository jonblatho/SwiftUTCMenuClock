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
	
	override func awakeFromNib() {
		// Link the menu from MainMenu.xib to be displayed when someone clicks on the menu bar item.
		statusItem.menu = menu
		
		// Set up a DateFormatter to display the time.
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "Etc/UTC")
		formatter.dateFormat = "HH:mm zzz"
		
		let calendar = Calendar.current
		
		// Set up a timer running every 0.01 seconds that gets the current time and formats it, if needed, for the menu bar.
		// (Most other utilities like this one run a timer like this every 1.00 seconds, which is bad and wrong.)
		Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
			let now = Date(timeIntervalSinceNow: 0)
			
			// Check the current millisecond to see if we actually need to update the time string.
			let centisecond = calendar.component(.nanosecond, from: now) / 10000000
			switch centisecond {
			case 0:
				// We've got a second on the second (approximately). We need to update the time.
				// Format the current time into a human-readable string and set the title.
				let timeString = formatter.string(from: now)
				self.statusItem.attributedTitle = self.formatTimeString(string: timeString)
			default:
				// We don't need to format the time, so...do nothing.
				break
			}
			
			
		}
	}
	
	private func formatTimeString(string: String) -> NSMutableAttributedString {
		// Set up an attributed string.
		let attributedString = NSMutableAttributedString(string: string)
		// Set the range to cover the entire character range.
		let range = NSRange(location: 0, length: string.count)
		// Apply the monospaced digit system font.
		attributedString.addAttribute(.font, value: NSFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular), range: range)
		
		// We're done here; return the attributed string.
		return attributedString
	}
	
	@IBAction func quitClicked(_ sender: Any) {
		// Quit the application.
		NSApplication.shared.terminate(self)
	}
}
