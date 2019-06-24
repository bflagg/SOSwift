import XCTest
@testable import SOSwift

class ContactPointOrPlaceTests: XCTestCase {

    fileprivate class TestClass: Codable, Testable {
        var contactPoint: ContactPointOrPlace?
        var place: ContactPointOrPlace?
        var multiple: [ContactPointOrPlace]?
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSingleDecodes() {
        let json = """
            {
                "contactPoint" : {
                    "@type" : "ContactPoint",
                    "name" : "Contact Point"
                },
                "place" : {
                    "@type" : "Place",
                    "name" : "A Place"
                }
            }
        """
        
        let testObject: TestClass
        do {
            testObject = try TestClass.make(with: json)
        } catch {
            XCTFail()
            return
        }
        
        guard let contactPoint = testObject.contactPoint as? ContactPointOrPlace else {
            XCTFail()
            return
        }
        
        switch contactPoint {
        case .place:
            XCTFail()
        case .contactPoint(let value):
            XCTAssertEqual(value.name, "Contact Point")
        }
        
        guard let place = testObject.place as? ContactPointOrPlace else {
            XCTFail()
            return
        }
        
        switch place {
        case .contactPoint:
            XCTFail()
        case .place(let value):
            XCTAssertEqual(value.name, "A Place")
        }
    }
    
    func testSingleEncodes() {
        let testObject = TestClass()
        
        let contactPoint = ContactPoint()
        contactPoint.name = "Alpha"
        
        let place = Place()
        place.name = "Beta"
        
        testObject.contactPoint = .contactPoint(value: contactPoint)
        testObject.place = .place(value: place)
        
        let json: String
        do {
            json = try testObject.json()
        } catch {
            XCTFail()
            return
        }
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let dictionary: [String : Any]
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String : Any] else {
                XCTFail()
                return
            }
            
            dictionary = dict
        } catch {
            XCTFail()
            return
        }
        
        guard let cp = dictionary["contactPoint"] as? [String : Any], let alpha = cp["name"] as? String else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(alpha, "Alpha")
        
        guard let p = dictionary["place"] as? [String : Any], let beta = p["name"] as? String else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(beta, "Beta")
    }
    
    func testMultipleDecodes() throws {
        let json = """
        {
            "multiple": [
                {
                    "@type": "ContactPoint",
                    "name": "CP Item"
                },
                {
                    "@type": "Place",
                    "name": "P Item"
                }
            ]
        }
        """
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let testable: TestClass = try JSONDecoder().decode(TestClass.self, from: data)
        
        guard let multiple = testable.multiple else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(multiple.count, 2)
        
        guard let contactPoint = multiple[0] as? ContactPointOrPlace else {
            XCTFail()
            return
        }
        
        switch contactPoint {
        case .contactPoint(let value):
            XCTAssertEqual(value.name, "CP Item")
        default:
            XCTFail()
        }
        
        guard let place = multiple[1] as? ContactPointOrPlace else {
            XCTFail()
            return
        }
        
        switch place {
        case .place(let value):
            XCTAssertEqual(value.name, "P Item")
        default:
            XCTFail()
        }
    }
    
    func testMultipleEncodes() throws {
        let testable = TestClass()
        testable.multiple = [.contactPoint(value: ContactPoint()), .place(value: Place())]
        
        let json = try testable.json()
        XCTAssertTrue(json.contains("\"multiple\":["))
    }
}
