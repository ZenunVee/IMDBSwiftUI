//
//  CacheManager.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: CacheManager Keys
enum CacheKeys {
    static let popularMoviesPage = "popularMoviesPage"
    static let movieDetailsPrefix = "movieDetails"

    // Generate a page-specific cache key
    static func popularMoviesPageKey(_ page: Int) -> String {
        return "\(popularMoviesPage)\(page)"
    }

    // Generate a id-specific cache key
    static func movieDetailsKey(_ id: Int) -> String {
        return "\(movieDetailsPrefix)\(id)"
    }
}

// MARK: CacheManager
class CacheManager {
    static let shared = CacheManager()
    private let userDefaults = UserDefaults.standard

    // In-memory cache for movie lists by page
    private var moviesPageCache: [String: [Movie]] = [:]

    // In-memory cache for individual movie details, keyed by movie ID
    private var movieDetailsCache: [Int: MovieDetail] = [:]

    // Method to cache a list of movies in memory
    func cacheMoviesInMemory(_ movies: [Movie], forKey key: String) {
        moviesPageCache[key] = movies
    }

    // Method to get a cached list of movies from memory
    func getCachedMoviesFromMemory(forKey key: String) -> [Movie]? {
        return moviesPageCache[key]
    }

    // Method to cache individual movie details in memory
    func cacheMovieDetailInMemory(_ movieDetail: MovieDetail) {
        movieDetailsCache[movieDetail.id] = movieDetail
    }

    // Method to get a cached movie detail from memory
    func getCachedMovieDetailFromMemory(forId id: Int) -> MovieDetail? {
        return movieDetailsCache[id]
    }

    // Existing methods for caching and retrieving movies lists in UserDefaults...
    func cacheMovies(_ movies: [Movie], forKey key: String) {
        do {
            let data = try JSONEncoder().encode(movies)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error caching movies: \(error)")
        }
    }

    func getCachedMovies(forKey key: String) -> [Movie]? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            print("Error retrieving cached movies: \(error)")
            return nil
        }
    }

    // Methods for caching and retrieving individual movie details in UserDefaults...
    func cacheMovieDetail(_ movieDetail: MovieDetail, forId id: Int) {
        let key = CacheKeys.movieDetailsKey(id)
        do {
            let data = try JSONEncoder().encode(movieDetail)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Error caching movie detail: \(error)")
        }
    }

    func getCachedMovieDetail(forId id: Int) -> MovieDetail? {
        let key = CacheKeys.movieDetailsKey(id)
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode(MovieDetail.self, from: data)
        } catch {
            print("Error retrieving cached movie detail: \(error)")
            return nil
        }
    }
}

