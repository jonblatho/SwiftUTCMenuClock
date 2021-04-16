import XCTest
@testable import Time

final class TimeTests: XCTestCase {    
    func testFormattedMonthAndDay() {
        XCTAssertEqual(Time.formattedMonthAndDay(date: Date(timeIntervalSince1970: 0)), "Jan 1")
        XCTAssertEqual(Time.formattedMonthAndDay(date: Date(timeIntervalSince1970: 178)), "Jan 1")
        XCTAssertEqual(Time.formattedMonthAndDay(date: Date(timeIntervalSince1970: 86400)), "Jan 2")
    }
    
    func testFormattedTime() {
        XCTAssertEqual(Time.formattedTime(date: Date(timeIntervalSince1970: 0), includeSeconds: true), "00:00:00")
        XCTAssertEqual(Time.formattedTime(date: Date(timeIntervalSince1970: 178), includeSeconds: true), "00:02:58")
        XCTAssertEqual(Time.formattedTime(date: Date(timeIntervalSince1970: 86400), includeSeconds: false), "00:00")
        XCTAssertEqual(Time.formattedTime(date: Date(timeIntervalSince1970: 172800), includeSeconds: false), "00:00")
    }
}
