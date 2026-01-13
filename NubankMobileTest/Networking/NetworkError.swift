import Foundation

/// Erros padronizados da camada de rede
enum NetworkError: Error, Equatable {
    case badURL
    case invalidResponse
    case decodingError(underlying: Error)
    case statusCode(Int, data: Data?)
    case notFound
    case unauthorized
    case timeout
    case underlying(Error)
    case unknown
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
            case (.badURL, .badURL): return true
            case (.invalidResponse, .invalidResponse): return true
            case (.notFound, .notFound): return true
            case (.unauthorized, .unauthorized): return true
            case (.timeout, .timeout): return true
            case (.unknown, .unknown): return true
            case let (.statusCode(a, _), .statusCode(b, _)): return a == b
            case (.decodingError, .decodingError): return true
            case let (.underlying(a), .underlying(b)):
                return (a as NSError).domain == (b as NSError).domain &&
                (a as NSError).code == (b as NSError).code
            default:
                return false
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badURL:
                return "URL inválida."
            case .invalidResponse:
                return "Resposta inválida do servidor."
            case .decodingError:
                return "Falha ao processar a resposta."
            case .statusCode(let code, _):
                switch code {
                    case 400: return "Requisição inválida."
                    case 401: return "Não autorizado."
                    case 403: return "Acesso proibido."
                    case 404: return "Recurso não encontrado."
                    case 422: return "Dados inválidos enviados."
                    case 500: return "Erro no servidor. Tente novamente."
                    default: return "Erro de rede (código \(code))."
                }
            case .notFound:
                return "Recurso não encontrado."
            case .unauthorized:
                return "Não autorizado."
            case .timeout:
                return "Tempo limite atingido."
            case .underlying(let err):
                return err.localizedDescription
            case .unknown:
                return "Erro desconhecido."
        }
    }
}
