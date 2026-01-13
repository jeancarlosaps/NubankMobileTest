//
//  DummyTests.swift
//  NubankMobileTestTests
//
//  Created by Jean Carlos on 01/12/25.
//

import XCTest
@testable import NubankMobileTest

final class DummyTests: XCTestCase {
    @MainActor func test_canAccessViewModel() {
        let mock = ShortenURLUseCaseMock()
        let vm = URLShortenerViewModel(shortenURLUseCase: mock)
        XCTAssertNotNil(vm)
    }
}
