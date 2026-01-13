//
//  PreviewMocks.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 01/12/25.
//

import Foundation

final class PreviewShortenURLUseCaseMock: ShortenURLUseCaseProtocol {
    var result: ShortenedItem
    
    init(result: ShortenedItem) {
        self.result = result
    }
    
    func execute(url: String) async throws -> ShortenedItem {
        return result
    }
}
