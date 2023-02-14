//
//  File.swift
//  
//
//  Created by Gabor Shaio on 2023-02-13.
//

import Foundation

public enum Kind: String, Decodable
{
    case
    unknown = "",
    iMac = "iMac",
    iMacPro = "iMac Pro",
    macBook = "MacBook",
    macBookAir = "MacBook Air",
    macBookPro = "MacBook Pro",
    macMini = "Mac mini",
    macPro = "Mac Pro",
    macProServer = "Mac Pro Server"
    
    public var name: String
    {
        self.rawValue
    }
}
