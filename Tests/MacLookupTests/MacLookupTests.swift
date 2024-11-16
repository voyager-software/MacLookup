import XCTest
@testable import MacLookup

final class MacLookupTests: XCTestCase {
    func testNilMac() async throws {
        let mac = await MacLookup.shared.find(model: "INVALID_MODEL")
        XCTAssertNil(mac)
    }

    func testNotNilMac() async throws {
        let mac = await MacLookup.shared.find(model: "iMac21,2")
        XCTAssertNotNil(mac)
    }

    func testMacName() async throws {
        let mac = await MacLookup.shared.find(model: "iMac21,2")
        XCTAssertEqual(mac?.name, "iMac (24-inch, M1, 2021)")
    }

    func testFindAll() async throws {
        let macs = await MacLookup.shared.findAll()
        XCTAssertEqual(macs.count, 117)
    }

    func testCounts() async throws {
        let macs = await MacLookup.shared.findAll()

        let unknowns = macs.filter { $0.kind == .unknown }
        let imacs = macs.filter { $0.kind == .iMac }
        let imacpros = macs.filter { $0.kind == .iMacPro }
        let macbooks = macs.filter { $0.kind == .macBook }
        let macbookairs = macs.filter { $0.kind == .macBookAir }
        let macbookpros = macs.filter { $0.kind == .macBookPro }
        let macminis = macs.filter { $0.kind == .macMini }
        let macpros = macs.filter { $0.kind == .macPro }
        let servers = macs.filter { $0.kind == .macProServer }

        XCTAssertEqual(unknowns.count, 0)
        XCTAssertEqual(imacs.count, 25)
        XCTAssertEqual(imacpros.count, 1)
        XCTAssertEqual(macbooks.count, 7)
        XCTAssertEqual(macbookairs.count, 19)
        XCTAssertEqual(macbookpros.count, 49)
        XCTAssertEqual(macminis.count, 9)
        XCTAssertEqual(macpros.count, 5)
        XCTAssertEqual(servers.count, 2)
    }

    #if os(macOS) || targetEnvironment(macCatalyst)
        func testGetModel() async throws {
            let model = await MacLookup.shared.getModel()
            XCTAssertNotNil(model)
            XCTAssertTrue((model ?? "").contains("Mac"))
        }
    #endif

    func testMbp13m2_2022() async throws {
        let mbp13m2_2022 = await MacLookup.shared.find(model: "Mac14,7")

        XCTAssertEqual(mbp13m2_2022?.name, "MacBook Pro (13-inch, M2, 2022)")
    }
}
