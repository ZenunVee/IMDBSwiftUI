//
//  PopularMoviesResponse.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: Popular Movies response
struct PopularMoviesResponse: Decodable {
    let results: [Movie]
}
