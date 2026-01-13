//
//  URLShortenerServiceMock.swift
//  NubankMobileTestTests
//
//  Created by Jean Carlos on 01/12/25.
//

import Foundation
@testable import NubankMobileTest

final class URLShortenerServiceMock: URLShortenerServiceProtocol {
    
    var result: ShortenedItem?
    var errorToThrow: Error?
    
    func shortenURL(_ url: String) async throws -> ShortenedItem {
        if let error = errorToThrow {
            throw error
        }
        
        guard let result = result else {
            fatalError("Mock error: No result set before calling shortenURL")
        }
        
        return result
    }
}
