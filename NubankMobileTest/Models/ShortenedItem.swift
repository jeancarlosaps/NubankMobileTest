//
//  ShortenedItem.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

struct ShortenedItem: Identifiable, Equatable {
    let id: String
    let originalURL: String
    let shortURL: String
    
    init(response: ShortenURLResponse) {
        self.id = response.alias
        self.originalURL = response.links.original
        self.shortURL = response.links.short
    }
    
    init(id: String, originalURL: String, shortURL: String) {
        self.id = id
        self.originalURL = originalURL
        self.shortURL = shortURL
    }
}
