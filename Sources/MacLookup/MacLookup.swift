//
//  MacLookup.swift
//  Created by Gabor Shaio on 2022-01-02.
//

import Foundation

class MacLookup
{
    private init() {}
    
    static var shared = MacLookup()
    
    private var macs: [Mac] = []
    
    func find(model: String) -> Mac?
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
