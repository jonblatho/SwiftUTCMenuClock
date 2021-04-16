import Foundation

public class Time {
    public struct Components: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let dayOfWeek = Components(rawValue: 1)
        public static let monthAndDay = Components(rawValue: 2)
        public static let seconds = Components(rawValue: 3)
    }
    
    public static func formattedDayOfWeek(date: Date = .now(), timeZone: TimeZone = .utc) -> String {
        let utcComponents = calendar.dateComponents(in: timeZone, from: date)
        
        let weekday = utcComponents.weekday!
        switch weekday {
        case 1: return "Sun "
        case 2: return "Mon "
        case 3: return "Tue "
        case 4: return "Wed "
        case 5: return "Thu "
        case 6: return "Fri "
        case 7: return "Sat "
        default: return ""
        }
    }
    
    public static func formattedMonthAndDay(date: Date = .now(), timeZone: TimeZone = .utc) -> String {
        let utcComponents = calendar.dateComponents(in: timeZone, from: date)
        
        let month = utcComponents.month!
        var monthFormatted = ""
        switch month {
        case 1:  monthFormatted += "Jan"
        case 2:  monthFormatted += "Feb"
        case 3:  monthFormatted += "Mar"
        case 4:  monthFormatted += "Apr"
        case 5:  monthFormatted += "May"
        case 6:  monthFormatted += "Jun"
        case 7:  monthFormatted += "Jul"
        case 8:  monthFormatted += "Aug"
        case 9:  monthFormatted += "Sep"
        case 10: monthFormatted += "Oct"
        case 11: monthFormatted += "Nov"
        case 12: monthFormatted += "Dec"
        default: break
        }
        let day = String(describing: utcComponents.day!)
        return "\(monthFormatted) \(day) "
    }
    
    public static func formattedTime(date: Date = .now(), timeZone: TimeZone = .utc, includeSeconds: Bool, flashTimeSeparators: Bool = false) -> String {
        let utcComponents = calendar.dateComponents(in: timeZone, from: date)
        
        let hour = formatDateComponentInteger(utcComponents.hour!)
        let minute = formatDateComponentInteger(utcComponents.minute!)
        let second = utcComponents.second!
        var timeString = "\(hour):\(minute)"
        
        if includeSeconds {
            timeString += ":\(formatDateComponentInteger(second))"
        }
        
        if flashTimeSeparators && second % 2 == 0 {
            return timeString.replacingOccurrences(of: ":", with: " ")
        } else {
            return timeString
        }
        
    }
    
    public static func formattedDateAndTime(date: Date = .now(), timeZone: TimeZone = .utc, components: [Components], flashTimeSeparators: Bool = false) -> String {
        var formattedString = ""
        if components.contains(.dayOfWeek) {
            formattedString += formattedDayOfWeek(date: date, timeZone: timeZone)
        }
        if components.contains(.monthAndDay) {
            formattedString += formattedMonthAndDay(date: date, timeZone: timeZone)
        }
        let includeSeconds = components.contains(.seconds)
        formattedString += formattedTime(date: date, timeZone: timeZone, includeSeconds: includeSeconds, flashTimeSeparators: flashTimeSeparators)
        return formattedString
    }
    
    // MARK: - Private
    
    /// The current calendar.
    private static let calendar = Calendar.current
    
    /**
     Formats a date component integer to add a leading zero, if needed.
     */
    private static func formatDateComponentInteger(_ component: Int) -> String {
        if component < 10 {
            return "0\(component)"
        } else {
            return String(describing: component)
        }
    }
}
