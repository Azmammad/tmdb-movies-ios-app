//
//  NetworkService.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 05.01.26.
//
import Foundation

protocol NetworkService {
    //func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T

}

final class DefaultNetworkService: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
            let request = endpoint.makeRequest()
            
            switch request {
            case .success(let urlRequest):
                do {
                    let (data, response) = try await session.data(for: urlRequest)
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        
                        guard (200...299).contains(statusCode) else {
                            throw NetworkError.serverError(statusCode: statusCode)
                        }
                    }
                    
                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        throw NetworkError.decodingError
                    }
                    
                } catch {
                    throw error
                }
                
            case .failure(let error):
                throw error
            }
        }
}
