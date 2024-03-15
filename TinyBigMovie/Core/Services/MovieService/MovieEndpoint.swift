//
//  MovieEndpoint.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: MovieEndpoint
enum MovieEndpoint: APIEndpoint {
    case popular(page: Int)
    case details(id: Int)
    case credits(id: Int)

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .details(let id):
            return "/movie/\(id)"
        case .credits(let id):
            return "/movie/\(id)/credits"
        }
    }

    var queryParams: [String: String]? {
        switch self {
        case .popular(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }
}
