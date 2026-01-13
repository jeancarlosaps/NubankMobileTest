//
//  HTTPClient.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import Foundation

final class HTTPClient: HTTPClientProtocol {
    
    func post<T: Codable, U: Codable>(_ url: String, body: T) async throws -> U {
        
        // 1. Validar URL
        guard let endpoint = URL(string: url) else {
            throw NetworkError.badURL
        }
        
        // 2. Construção da request
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.decodingError(underlying: error)
        }
        
        // 3. Execução
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            if (error as NSError).code == NSURLErrorTimedOut {
                throw NetworkError.timeout
            }
            throw NetworkError.underlying(error)
        }
        
        // 4. Validação da resposta
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch http.statusCode {
            case 200...299:
                break
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.statusCode(http.statusCode, data: data)
        }
        
        // 5. Decodificação
        do {
            return try JSONDecoder().decode(U.self, from: data)
        } catch {
            throw NetworkError.decodingError(underlying: error)
        }
    }
}
