//
//  HTTPClientMock.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation
@testable import NubankMobileTest

final class HTTPClientMock: HTTPClientProtocol {
    
    var mockData: Data?
    var mockStatusCode: Int = 200
    var errorToThrow: Error?
    
    func post<T: Codable, U: Codable>(
        _ url: String,
        body: T
    ) async throws -> U {
        
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        
        let response = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: mockStatusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        guard (200...299).contains(mockStatusCode) else {
            throw NetworkError.statusCode(mockStatusCode, data: mockData)
        }
        
        guard let data = mockData else {
            fatalError("Mock error: mockData was not set before calling post")
        }
        
        return try JSONDecoder().decode(U.self, from: data)
    }
}
