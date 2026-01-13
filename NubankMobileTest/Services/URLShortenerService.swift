//
//  URLShortenerService.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

final class URLShortenerService: URLShortenerServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let baseURL = "https://url-shortener-server.onrender.com/api/alias"
    
    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func shortenURL(_ url: String) async throws -> ShortenedItem {
        let requestBody = ShortenURLRequest(url: url)
        
        let response: ShortenURLResponse = try await httpClient.post(
            baseURL,
            body: requestBody
        )
        
        return ShortenedItem(response: response)
    }
}
