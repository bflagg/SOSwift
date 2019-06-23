import XCTest
@testable import SOSwift

class BrandOrOrganizationTests: XCTestCase {

    fileprivate class TestClass: Codable, Testable {
        var brand: BrandOrOrganization?
        var organization: BrandOrOrganization?
        var multiple: [BrandOrOrganization]?
        
        private enum CodingKeys: String, CodingKey {
            case brand
            case organization
            case multiple
        }
        
        init() {
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.brand = try container.decodeBrandOrOrganizationIfPresent(forKey: .brand)
            self.organization = try container.decodeBrandOrOrganizationIfPresent(forKey: .organization)
            self.multiple = try container.decodeBrandsOrOrganizationsIfPresent(forKey: .multiple)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(self.brand, forKey: .brand)
            try container.encodeIfPresent(self.organization, forKey: .organization)
            try container.encodeIfPresent(self.multiple, forKey: .multiple)
        }
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
                "brand" : {
                    "@type" : "Brand",
                    "name" : "Brand"
                },
                "organization" : {
                    "@type" : "Organization",
                    "name" : "Organization"
                }
            }
        """
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let testable: TestClass
        do {
            testable = try JSONDecoder().decode(TestClass.self, from: data)
        } catch {
            XCTFail()
            return
        }
        
        guard let brand = testable.brand as? SOBrandOrOrganization else {
            XCTFail()
            return
        }
        
        switch brand {
        case .organization:
            XCTFail()
        case .brand(let value):
            XCTAssertEqual(value.name, "Brand")
        }
        
        guard let organization = testable.organization as? SOBrandOrOrganization else {
            XCTFail()
            return
        }
        
        switch organization {
        case .brand:
            XCTFail()
        case .organization(let value):
            XCTAssertEqual(value.name, "Organization")
        }
    }
    
    func testSingleEncodes() {
        let testable = TestClass()
        testable.brand = SOBrandOrOrganization.brand(value: SOBrand())
        testable.organization = SOBrandOrOrganization.organization(value: Organization())
        
        let json: String
        do {
            json = try testable.json()
        } catch {
            XCTFail()
            return
        }
        
        XCTAssertTrue(json.contains("\"brand\":{\"@context\":\"http:\\/\\/www.schema.org\",\"@type\":\"Brand\"}"))
        XCTAssertTrue(json.contains("\"organization\":{\"@context\":\"http:\\/\\/www.schema.org\",\"@type\":\"Organization\"}"))
    }
    
    func testMultipleDecodes() {
        let json = """
            {
                "multiple" : [
                    {
                        "@type" : "Brand",
                        "name" : "Brand"
                    },
                    {
                        "@type" : "Organization",
                        "name" : "Organization"
                    }
                ]
            }
        """
        
        guard let data = json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let testable: TestClass
        do {
            testable = try JSONDecoder().decode(TestClass.self, from: data)
        } catch {
            XCTFail()
            return
        }
        
        guard let multiple = testable.multiple else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(multiple.count, 2)
        
        guard let brand = multiple[0] as? SOBrandOrOrganization else {
            XCTFail()
            return
        }
        
        switch brand {
        case .organization:
            XCTFail()
        case .brand(let value):
            XCTAssertEqual(value.name, "Brand")
        }
        
        guard let organization = multiple[1] as? SOBrandOrOrganization else {
            XCTFail()
            return
        }
        
        switch organization {
        case .brand:
            XCTFail()
        case .organization(let value):
            XCTAssertEqual(value.name, "Organization")
        }
    }
    
    func testMultipleEncodes() {
        let testable = TestClass()
        let brand = SOBrand()
        brand.name = "A Brand"
        let organization = Organization()
        organization.name = "An Organization"
        testable.multiple = [brand, organization]
        
        let json: String
        do {
            json = try testable.json()
        } catch {
            XCTFail()
            return
        }
        
        XCTAssertTrue(json.contains("\"multiple\":["))
    }
}
