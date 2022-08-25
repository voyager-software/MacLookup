//
//  MacLookup.swift
//  Created by Gabor Shaio on 2022-01-02.
//

import Foundation

#if os(macOS) || targetEnvironment(macCatalyst)
import IOKit
#endif

public class MacLookup
{
    private init() {}
    
    public static var shared = MacLookup()
    
    private var macs: [Mac] = []
    
    
    #if os(macOS) || targetEnvironment(macCatalyst)
    public func getModel() -> String?
    {
        let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        defer { IOObjectRelease(service) }
        
        if let modelData = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data,
           let cString = modelData.withUnsafeBytes({ $0.baseAddress?.assumingMemoryBound(to: UInt8.self) })
        {
            return String(cString: cString)
        }
        
        return nil
    }
    
    
    #endif
    
    func cpu() -> String {
        var size = 0
        sysctlbyname("machdep.cpu.brand_string", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: Int(size))
        sysctlbyname("machdep.cpu.brand_string", &machine, &size, nil, 0)
        return String(cString: machine)
        
    }
    
    public func find(model: String) -> Mac?
    {
        self.loadMacs()
        return self.macs.first(where: { $0.models.contains(model) })
    }
    
    private func loadMacs()
    {
        guard self.macs.isEmpty else { return }
        
        guard let jsonUrl = Bundle.module.url(forResource: "all-macs", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: jsonUrl) else { return }
        
        let decoder = JSONDecoder()
        let macs = try? decoder.decode([Mac].self, from: data)
        self.macs = macs ?? []
    }
}
