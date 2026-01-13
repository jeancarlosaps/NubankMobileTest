//
//  ShortenURLUseCaseTests.swift
//  NubankMobileTestTests
//
//  Created by Jean Carlos on 01/12/25.
//

import XCTest
@testable import NubankMobileTest

@MainActor
final class ShortenURLUseCaseTests: XCTestCase {
    
    private var sut: ShortenURLUseCase!
    private var mockService: URLShortenerServiceMock!
    
    override func setUp() {
        super.setUp()
        mockService = URLShortenerServiceMock()
        sut = ShortenURLUseCase(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_execute_success_shouldReturnShortenedItem() async throws {
        // Given
        let expected = ShortenedItem(
            id: "123",
            originalURL: "https://apple.com",
            shortURL: "https://nu.sh/123"
        )
        mockService.result = expected
        
        // When
        let result = try await sut.execute(url: "https://apple.com")
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func test_execute_failure_shouldThrowError() async {
        // Given
        mockService.errorToThrow = NetworkError.notFound
        
        do {
            _ = try await sut.execute(url: "https://apple.com")
            XCTFail("Expected failure, but succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .notFound)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
