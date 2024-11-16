//
//  Mac.swift
//  Created by Gabor Shaio on 2022-01-02.
//

import Foundation

public struct Mac: Decodable, Sendable {
    public let kind: Kind
    public let variant: String
    public let name: String
    public let colors: [String]
    public let models: [String]
    public let parts: [String]
}
