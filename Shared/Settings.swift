import Cocoa

internal enum Settings {
    case flashTimeSeparators
    case hasRunBefore
    case openAtLogin
    case showDate
    case showDayOfWeek
    case showSeconds
    
    internal var key: String {
        switch self {
        case .flashTimeSeparators:
            return "flashTimeSeparators"
        case .hasRunBefore:
            return "hasRunBefore"
        case .openAtLogin:
            return "openAtLogin"
        case .showDate:
            return "showDate"
        case .showDayOfWeek:
            return "showDayOfWeek"
        case .showSeconds:
            return "showSeconds"
        }
    }
    
    internal var isEnabled: Bool { settings.bool(forKey: key) }
    
    internal var menuItemState: NSControl.StateValue {
        if isEnabled {
            return .on
        } else {
            return .off
        }
    }
    
    internal func toggle(menuItem: NSMenuItem? = nil) {
        if isEnabled {
            disable(menuItem: menuItem)
        } else {
            enable(menuItem: menuItem)
        }
    }
    
    internal func enable(menuItem: NSMenuItem? = nil) {
        settings.set(true, forKey: key)
        menuItem?.state = .on
        menuItem?.menu?.update()
    }
    
    internal func disable(menuItem: NSMenuItem? = nil) {
        settings.set(false, forKey: key)
        menuItem?.state = .off
        menuItem?.menu?.update()
    }
    
    private var settings: UserDefaults { UserDefaults(suiteName: "6LDW4Q5KWU.com.jonblatho.SwiftUTCMenuClock")! }
}
