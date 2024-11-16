//
//  MacLookup.swift
//  Created by Gabor Shaio on 2022-01-02.
//

import Foundation

#if os(macOS) || targetEnvironment(macCatalyst)
    import IOKit
#endif

public actor MacLookup {
    // MARK: Lifecycle

    private init() {}

    // MARK: Public

    public static let shared = MacLookup()

    #if os(macOS) || targetEnvironment(macCatalyst)
        public func getModel() -> String? {
//        let port: mach_port_t = 0
            let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
            defer { IOObjectRelease(service) }

            if let property = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0),
               let value = property.takeUnretainedValue() as? Data
            {
                return String(data: value, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters)
            }

//        if let modelData = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data,
//           let cString = modelData.withUnsafeBytes({ $0.baseAddress?.assumingMemoryBound(to: UInt8.self) })
//        {
//            return String(cString: cString)
//        }

            return nil
        }
    #endif

    public func findAll() -> [Mac] {
        self.loadMacs()
        return self.macs
    }

    public func find(model: String) -> Mac? {
        self.loadMacs()
        return self.macs.first(where: { $0.models.contains(model) })
    }

    // MARK: Private

    private var macs: [Mac] = []

    private func loadMacs() {
        guard self.macs.isEmpty else { return }

        guard let jsonUrl = Bundle.module.url(forResource: "all-macs", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: jsonUrl) else { return }

        let decoder = JSONDecoder()
        let macs = try? decoder.decode([Mac].self, from: data)
        self.macs = macs ?? []
    }
}
