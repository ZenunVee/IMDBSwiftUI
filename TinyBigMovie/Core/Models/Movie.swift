//
//  Movie.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: Movie Model
struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double

    var posterURL: URL? {
        URL.tmdbImageURL(forPath: posterPath)
    }

    private enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
