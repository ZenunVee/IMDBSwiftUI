//
//  NetworkServiceProtocol.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
}
