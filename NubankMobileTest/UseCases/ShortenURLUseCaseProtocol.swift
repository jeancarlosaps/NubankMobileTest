//
//  ShortenURLUseCaseProtocol.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

protocol ShortenURLUseCaseProtocol {
    func execute(url: String) async throws -> ShortenedItem
}
