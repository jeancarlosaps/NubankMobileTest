//
//  URLShortenerServiceProtocol.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

protocol URLShortenerServiceProtocol {
    func shortenURL(_ url: String) async throws -> ShortenedItem
}
