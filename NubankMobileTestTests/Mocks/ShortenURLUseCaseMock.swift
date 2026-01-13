//
//  ShortenURLUseCaseMock.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation
@testable import NubankMobileTest

final class ShortenURLUseCaseMock: ShortenURLUseCaseProtocol {
    var result: ShortenedItem?
    var errorToThrow: Error?
    
    func execute(url: String) async throws -> ShortenedItem {
        if let error = errorToThrow { throw error }
        // force unwrap intencional em mock para sinalizar erro de teste, ou retorne um fallback
        return result!
    }
}
