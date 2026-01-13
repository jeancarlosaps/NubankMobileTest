//
//  NubankMobileTestApp.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import SwiftUI

@main
struct NubankMobileTestApp: App {
    var body: some Scene {
        WindowGroup {
            let httpClient = HTTPClient()
            let service = URLShortenerService(httpClient: httpClient)
            let useCase = ShortenURLUseCase(service: service)
            let viewModel = URLShortenerViewModel(shortenURLUseCase: useCase)
            
            ContentView(viewModel: viewModel)
        }
    }
}
