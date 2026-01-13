//
//  URLShortenerServiceTests.swift
//  NubankMobileTestTests
//
//  Created by Jean Carlos on 01/12/25.
//

import XCTest
@testable import NubankMobileTest

@MainActor
final class URLShortenerServiceTests: XCTestCase {
    
    private var sut: URLShortenerService!
    private var mockClient: HTTPClientMock!
    
    override func setUp() {
        super.setUp()
        mockClient = HTTPClientMock()
        sut = URLShortenerService(httpClient: mockClient)
    }
    
    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    func test_shortenURL_success_shouldReturnShortenedItem() async throws {
        // Given
        let response = ShortenURLResponse(
            alias: "xyz",
            links: Links(
                original: "https://apple.com",
                short: "https://nu.sh/xyz"
            )
        )
        
        let expectedResult = ShortenedItem(response: response)
        
        mockClient.mockData = try JSONEncoder().encode(response)
        mockClient.mockStatusCode = 200
        
        // When
        let result = try await sut.shortenURL("https://apple.com")
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_shortenURL_failure_shouldThrowNetworkError() async {
        // Given
        mockClient.errorToThrow = NetworkError.notFound
        
        do {
            _ = try await sut.shortenURL("https://apple.com")
            XCTFail("Expected failure, but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .notFound)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
