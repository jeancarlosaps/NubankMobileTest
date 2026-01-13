//
//  URLShortenerViewModelTests.swift.swift
//  NubankMobileTestTests
//
//  Created by Jean Carlos on 01/12/25.
//

import XCTest
@testable import NubankMobileTest

@MainActor
final class URLShortenerViewModelTests: XCTestCase {
    
    private var sut: URLShortenerViewModel!
    private var mockUseCase: ShortenURLUseCaseMock!
    
    override func setUp() {
        super.setUp()
        mockUseCase = ShortenURLUseCaseMock()
        sut = URLShortenerViewModel(shortenURLUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_initialState_shouldBeCorrect() {
        XCTAssertTrue(sut.shortenedItems.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_shortenURL_success_shouldAddItemAndClearField() async {
        let item = ShortenedItem(
            id: "abc123",
            originalURL: "https://apple.com",
            shortURL: "https://nu.sh/abc123"
        )
        mockUseCase.result = item
        sut.urlInput = "https://apple.com"
        
        await sut.shortenURL()
        
        XCTAssertEqual(sut.shortenedItems.count, 1)
        XCTAssertEqual(sut.shortenedItems.first, item)
        XCTAssertEqual(sut.urlInput, "")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_shortenURL_failure_shouldShowError() async {
        sut.urlInput = "apple" // inválida
        
        await sut.shortenURL()
        
        XCTAssertEqual(sut.errorMessage, "URL inválida. Use http:// ou https://")
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.shortenedItems.isEmpty)
    }
    
    func test_clearItems_shouldRemoveAllItems() async {
        let item = ShortenedItem(
            id: "xyz",
            originalURL: "https://test.com",
            shortURL: "https://nu.sh/xyz"
        )
        mockUseCase.result = item
        sut.urlInput = "https://test.com"
        await sut.shortenURL()
        
        XCTAssertEqual(sut.shortenedItems.count, 1)
        
        sut.clearItems()
        XCTAssertTrue(sut.shortenedItems.isEmpty)
    }
    
    func test_dismissError_shouldRemoveErrorMessage() async {
        sut.urlInput = "apple" // inválida
        await sut.shortenURL()
        
        XCTAssertNotNil(sut.errorMessage)
        
        sut.dismissError()
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_shortenURL_withWwwURL_shouldAutoAppendHTTPS() async {
        mockUseCase.result = ShortenedItem(
            id: "abc123",
            originalURL: "https://www.google.com",
            shortURL: "https://sho.rt/abc123"
        )
        
        sut.urlInput = "www.google.com"
        await sut.shortenURL()
        
        XCTAssertEqual(sut.shortenedItems.count, 1)
    }
    
    func test_prepareURL_shouldTrimWhitespace() async {
        mockUseCase.result = ShortenedItem(
            id: "xyz789",
            originalURL: "https://google.com",
            shortURL: "https://sho.rt/xyz789"
        )
        
        sut.urlInput = "   google.com   "
        await sut.shortenURL()
        
        XCTAssertEqual(sut.shortenedItems.count, 1)
    }
}
