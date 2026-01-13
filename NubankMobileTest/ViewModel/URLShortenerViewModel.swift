//
//  URLShortenerViewModel.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class URLShortenerViewModel: ObservableObject {
    
    // MARK: - Input
    @Published var urlInput: String = ""
    
    // MARK: - Output
    @Published private(set) var shortenedItems: [ShortenedItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    // MARK: - Dependencies
    private let shortenURLUseCase: ShortenURLUseCaseProtocol
    
    // MARK: - Initialization
    init(shortenURLUseCase: ShortenURLUseCaseProtocol) {
        self.shortenURLUseCase = shortenURLUseCase
    }
    
    // MARK: - Public Methods
    func shortenURL() async {
        // 1️⃣ Validação de formato da URL
        guard let url = prepareURL(from: urlInput) else {
            self.errorMessage = "URL inválida. Use http:// ou https://"
            return
        }
        
        // 2️⃣ Validação de duplicidade (BUG DO ESPAÇO EM BRANCO)
        if shortenedItems.contains(where: { $0.originalURL == url }) {
            self.errorMessage = "Essa URL já foi encurtada."
            return
        }
        
        // 3️⃣ Início do loading
        isLoading = true
        
        do {
            let result = try await shortenURLUseCase.execute(url: url)
            
            // 4️⃣ Atualização da UI COM ANIMAÇÃO (BÔNUS UX)
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                shortenedItems.append(result)
            }
            
            urlInput = ""
            
        } catch {
            errorMessage = "Ocorreu um erro ao encurtar a URL"
        }
        
        // 5️⃣ Final do loading
        isLoading = false
    }
    
    private func prepareURL(from input: String) -> String? {
        var formatted = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !formatted.lowercased().hasPrefix("http") {
            formatted = "https://" + formatted
        }
        
        guard let url = URL(string: formatted), url.host != nil, formatted.contains(".") else {
            return nil
        }
        
        return formatted
    }
    
    func dismissError() {
        errorMessage = nil
    }
    
    func clearItems() {
        shortenedItems = []
    }
}
