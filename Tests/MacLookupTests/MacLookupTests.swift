import XCTest
@testable import MacLookup

final class MacLookupTests: XCTestCase
{
    func testNilMac() throws
    {
        let mac = MacLookup.shared.find(model: "INVALID_MODEL")
        XCTAssertNil(mac)
    }
    
    func testNotNilMac() throws
    {
        let mac = MacLookup.shared.find(model: "iMac21,2")
        XCTAssertNotNil(mac)
    }
    
    func testMacName() throws
    {
        let mac = MacLookup.shared.find(model: "iMac21,2")
        XCTAssertEqual(mac?.name, "iMac (24-inch, M1, 2021)")
    }
    
    #if os(macOS) || targetEnvironment(macCatalyst)
    func testGetModel() throws
    {
        let model = MacLookup.shared.getModel()
        XCTAssertNotNil(model)
        XCTAssertTrue((model ?? "").contains("Mac"))
    }
    
   
    
    #endif
    
    func testcpu() throws
    {
        let x = MacLookup.shared.cpu()
        print(x)
    }
}
