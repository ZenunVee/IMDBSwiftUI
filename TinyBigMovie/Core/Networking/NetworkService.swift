//
//  NetworkService.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: NetworkService
class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url() else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        if let headers = endpoint.headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        if let json = String(data: data, encoding: .utf8) {
            print("JSON Response: \(json)")
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}



