//
//  MovieServiceProtocol.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: MovieServiceProtocol
protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
    func fetchMovieCredits(id: Int) async throws -> [CastMember]
}
