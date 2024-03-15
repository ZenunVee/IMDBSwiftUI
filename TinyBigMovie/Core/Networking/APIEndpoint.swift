//
//  APIEndpoint.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: APIEndpoint
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }

    func url() -> URL?
}

extension APIEndpoint {
    var baseURL: String {
        "https://api.themoviedb.org/3"
    }

    var headers: [String: String]? {
        return ["Authorization": "Bearer \(APIConfig.apiKey)", "accept": "application/json"]
    }

    func url() -> URL? {
        var components = URLComponents(string: baseURL.appending(path))
        components?.queryItems = queryParams?.map(URLQueryItem.init)
        return components?.url
    }
}

// MARK: NetworkError
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case responseParsingFailed
    case notFound
    case serverError
}

