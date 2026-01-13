//
//  ShortenURLResponse.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

struct ShortenURLResponse: Codable, Identifiable {
    let alias: String
    let links: Links
    
    var id: String { alias }
    
    enum CodingKeys: String, CodingKey {
        case alias
        case links = "_links"
    }
}

struct Links: Codable {
    let original: String
    let short: String
    
    enum CodingKeys: String, CodingKey {
        case original = "self"
        case short
    }
}
