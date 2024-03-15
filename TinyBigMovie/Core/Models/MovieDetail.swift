//
//  MovieDetail.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: MovieDetail Model
struct MovieDetail: Codable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let genres: [Genre]
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let tagline: String
    let runtime: Int

    var backdropURL: URL? {
        URL.tmdbImageURL(forPath: backdropPath)
    }

    var posterURL: URL? {
        URL.tmdbImageURL(forPath: posterPath)
    }

    var titleWithYear: String {
        return "\(title) (\(releaseDate.yearFromDateString()))"
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, backdropPath = "backdrop_path", genres, overview, tagline, runtime
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
