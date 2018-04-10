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
		
		// Set up a timer running every 0.03 seconds that gets the current time and formats it for the menu bar.
		// (Most other utilities like this one run a timer like this every 1.00 seconds, which is bad and wrong.)
		Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
			let now = Date(timeIntervalSinceNow: 0)
			
			let dateString = formatter.string(from: now)
			
			// To style this with monospaced digits (so other menu bar items don't wobble side-to-side with variable digit widths), we need to set up a NSMutableAttributedString. Joy!
			let attributedString = NSMutableAttributedString(string: dateString)
			// Set the range to cover the entire character range.
			let range = NSRange(location: 0, length: dateString.count)
			// And finally, apply the monospaced digit system font.
			attributedString.addAttribute(.font, value: NSFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular), range: range)
			
			// And it's done! Set the title for the menu bar item.
			self.statusItem.attributedTitle = attributedString
		}
	}
	
	@IBAction func quitClicked(_ sender: Any) {
		// Quit the application.
		NSApplication.shared.terminate(self)
	}
}
