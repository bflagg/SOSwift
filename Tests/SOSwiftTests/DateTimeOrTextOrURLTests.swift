import XCTest
@testable import SOSwift

class DateTimeOrTextOrURLTests: XCTestCase {
    
    static var allTests = [
        ("testSingleDecodes", testSingleDecodes),
        ("testSingleEncodes", testSingleEncodes),
        ("testMultipleDecodes", testMultipleDecodes),
        ("testMultipleEncodes", testMultipleEncodes),
    ]
    
    fileprivate class TestClass: Codable, Testable {
        var dateTime: DateTimeOrURLOrText?
        var text: DateTimeOrURLOrText?
        var url: DateTimeOrURLOrText?
        var multiple: [DateTimeOrURLOrText]?
    }
    
    var dateComponents: DateComponents {
        return DateComponents(calendar: Calendar.current, timeZone: TimeZone(secondsFromGMT: 21600), era: nil, year: 2017, month: 10, day: 26, hour: 8, minute: 13, second: 0, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
    }
    
    var dateString: String {
        return "2017-10-26T02:13:00Z"
    }
    
    func testSingleDecodes() {
        let json = """
            {
                "dateTime" : "2017-10-26T08:13:00+6000",
                "text" : "Hello World",
                "url" : "https://www.google.com"
            }
        """
        
        let testObject: TestClass
        do {
            testObject = try TestClass.make(with: json)
        } catch {
            XCTFail()
            return
        }
        
        guard let dateTime = testObject.dateTime as? DateTime else {
            XCTFail()
            return
        }
        
        let dtDate = dateTime.date
        let dcDate = dateComponents.date
        
        XCTAssertEqual(dtDate, dcDate)
        
        guard let text = testObject.text as? String else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(text, "Hello World")
        
        guard let url = testObject.url as? URL else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(url.host, "www.google.com")
    }

    func testSingleEncodes() {
        let testObject = TestClass()
        testObject.dateTime = .dateTime(value: DateTime(date: dateComponents.date!))
        testObject.text = .text(value: "Goodbye")
        testObject.url = .url(value: URL(string: "https://www.apple.com")!)
        
        let dictionary: [String : Any]
        do {
            dictionary = try testObject.dictionary()
        } catch {
            XCTFail()
            return
        }
        
        guard let dt = dictionary["dateTime"] as? String else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(dt, dateString)
        
        guard let t = dictionary["text"] as? String else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(t, "Goodbye")
        
        guard let u = dictionary["url"] as? String, let url = URL(string: u) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(url.host, "www.apple.com")
    }
    
    func testMultipleDecodes() throws {
        let json = """
        {
            "multiple": [
                "2019-06-16T08:14:00-5000",
                "https://www.google.com",
                "Hello World",
            ]
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let testable = try JSONDecoder().decode(TestClass.self, from: data)
        
        guard let multiple = testable.multiple else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(multiple.count, 3)
        
        guard
            let dateTime = multiple[0] as? DateTimeOrURLOrText,
            let url = multiple[1] as? DateTimeOrURLOrText,
            let text = multiple[2] as? DateTimeOrURLOrText
            else {
                XCTFail()
                return
        }
        
        switch dateTime {
        case .dateTime(let value):
            let components = DateComponents(calendar: .gregorian, timeZone: .gmt, era: nil, year: 2019, month: 6, day: 16, hour: 13, minute: 14, second: 0, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
            guard let date = value.date, let compare = components.date else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(Calendar.gregorian.compare(date, to: compare, toGranularity: .second), .orderedSame)
        default:
            XCTFail()
        }
        
        switch url {
        case .url(let value):
            XCTAssertEqual(value.scheme, "https")
            XCTAssertEqual(value.host, "www.google.com")
        default:
            XCTFail()
        }
        
        switch text {
        case .text(let value):
            XCTAssertEqual(value, "Hello World")
        default:
            XCTFail()
        }
    }
    
    func testMultipleEncodes() throws {
        let dateTime = DateTimeOrURLOrText.dateTime(value: DateTime(rawValue: "2019-06-16T08:14:00-5000")!)
        let url = DateTimeOrURLOrText.url(value: URL(string: "https://www.google.com")!)
        let text = DateTimeOrURLOrText.text(value: "Hello World")
        
        let testObject = TestClass()
        testObject.multiple = [dateTime, url, text]
        
        let dictionary = try testObject.dictionary()
        XCTAssertEqual(dictionary.keys.count, 1)
        
        guard let multiple = dictionary["multiple"] as? [String] else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(multiple[0], "2019-06-16T13:14:00Z")
        XCTAssertEqual(multiple[1], "https://www.google.com")
        XCTAssertEqual(multiple[2], "Hello World")
    }
}
