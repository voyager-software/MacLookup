import XCTest
@testable import MacLookup

final class MacLookupTests: XCTestCase {
    func testNilMac() {
        let mac = MacLookup.shared.find(model: "INVALID_MODEL")
        XCTAssertNil(mac)
    }

    func testNotNilMac() {
        let mac = MacLookup.shared.find(model: "iMac21,2")
        XCTAssertNotNil(mac)
    }

    func testMacName() {
        let mac = MacLookup.shared.find(model: "iMac21,2")
        XCTAssertEqual(mac?.name, "iMac (24-inch, M1, 2021)")
    }

    func testFindAll() {
        let macs = MacLookup.shared.findAll()
        XCTAssertEqual(macs.count, 153)
    }

    func testCounts() {
        let macs = MacLookup.shared.findAll()

        let unknowns = macs.filter { $0.kind == .unknown }
        let imacs = macs.filter { $0.kind == .iMac }
        let imacpros = macs.filter { $0.kind == .iMacPro }
        let macbooks = macs.filter { $0.kind == .macBook }
        let macbookairs = macs.filter { $0.kind == .macBookAir }
        let macbookpros = macs.filter { $0.kind == .macBookPro }
        let macminis = macs.filter { $0.kind == .macMini }
        let macpros = macs.filter { $0.kind == .macPro }
        let servers = macs.filter { $0.kind == .macProServer }
        let studios = macs.filter { $0.kind == .macStudio }

        XCTAssertEqual(unknowns.count, 0)

        XCTAssertEqual(imacs.count, 32)
        XCTAssertEqual(imacpros.count, 1)
        XCTAssertEqual(macbooks.count, 7)
        XCTAssertEqual(macbookairs.count, 26)
        XCTAssertEqual(macbookpros.count, 58)
        XCTAssertEqual(macminis.count, 13)
        XCTAssertEqual(macpros.count, 8)
        XCTAssertEqual(servers.count, 2)
        XCTAssertEqual(studios.count, 6)
    }

    #if os(macOS) || targetEnvironment(macCatalyst)
    func testGetModel() {
        let model = MacLookup.shared.getModel()
        XCTAssertNotNil(model)
        XCTAssertTrue((model ?? "").contains("Mac"))
    }
    #endif

    func testMbp13m2_2022() {
        let mbp13m2_2022 = MacLookup.shared.find(model: "Mac14,7")

        XCTAssertEqual(mbp13m2_2022?.name, "MacBook Pro (13-inch, M2, 2022)")
    }
}
