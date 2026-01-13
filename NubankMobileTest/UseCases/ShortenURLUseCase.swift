//
//  ShortenURLUseCase.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

final class ShortenURLUseCase: ShortenURLUseCaseProtocol {
    
    private let service: URLShortenerServiceProtocol
    
    init(service: URLShortenerServiceProtocol) {
        self.service = service
    }
    
    func execute(url: String) async throws -> ShortenedItem {
        guard isValidURL(url) else {
            throw ShortenURLUseCaseError.invalidURL
        }
        
        return try await service.shortenURL(url)
    }
    
    private func isValidURL(_ text: String) -> Bool {
        guard let url = URL(string: text) else { return false }
        return url.scheme != nil && url.host != nil
    }
}

enum ShortenURLUseCaseError: Error, LocalizedError {
    case invalidURL
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL provided is invalid."
        }
    }
}
