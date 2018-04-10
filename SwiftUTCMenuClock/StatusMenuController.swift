//
//  StatusMenuController.swift
//  SwiftUTCMenuClock
//
//  Created by Jonathan Thornton on 4/8/18.
//  Copyright © 2018 Jonathan Thornton. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	
	@IBOutlet weak var menu: NSMenu!
	
	override func awakeFromNib() {
		statusItem.menu = menu
		
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "Etc/UTC")
		formatter.dateFormat = "HH:mm"
		
		Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
			let now = Date(timeIntervalSinceNow: 0)
			
			let dateString = "\(formatter.string(from: now)) UTC"
			let attributedString = NSMutableAttributedString(string: dateString)
			let range = NSRange(location: 0, length: dateString.count)
			attributedString.addAttribute(.font, value: NSFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular), range: range)
			
			self.statusItem.attributedTitle = attributedString
		}
	}
	
	@IBAction func openAtLoginClicked(_ sender: Any) {
		
	}
	
	@IBAction func quitClicked(_ sender: Any) {
		// Quit the application.
		NSApplication.shared.terminate(self)
	}
}
