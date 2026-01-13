//
//  HTTPClientProtocol.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

protocol HTTPClientProtocol {
    func post<T: Codable, U: Codable>(_ url: String,body: T) async throws -> U
}
