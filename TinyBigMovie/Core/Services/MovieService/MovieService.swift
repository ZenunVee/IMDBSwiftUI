//
//  MovieService.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: MovieService
class MovieService: MovieServiceProtocol {
    private var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let cacheKey = CacheKeys.popularMoviesPageKey(page)

        // Try to retrieve movies for the page from in-memory cache first
        if let cachedMovies = CacheManager.shared.getCachedMoviesFromMemory(forKey: cacheKey) {
            return cachedMovies
        }

        do {
            let response: PopularMoviesResponse = try await networkService.request(endpoint: MovieEndpoint.popular(page: page))
            // Cache the fetched movies both in-memory and in UserDefaults
            CacheManager.shared.cacheMoviesInMemory(response.results, forKey: cacheKey)
            CacheManager.shared.cacheMovies(response.results, forKey: cacheKey)
            return response.results
        } catch {
            // If network request fails, try to retrieve cached movies from UserDefaults
            if let cachedMovies = CacheManager.shared.getCachedMovies(forKey: cacheKey) {
                return cachedMovies
            } else {
                // If no cached movies available and network request failed, rethrow the error
                throw error
            }
        }
    }

    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        // First, try to get the movie detail from the in-memory cache
        if let cachedMovieDetail = CacheManager.shared.getCachedMovieDetailFromMemory(forId: id) {
            return cachedMovieDetail
        }

        do {
            // If not in memory, try to fetch movie details from the network
            let response: MovieDetail = try await networkService.request(endpoint: MovieEndpoint.details(id: id))
            // Cache the fetched movie detail in both memory and UserDefaults
            CacheManager.shared.cacheMovieDetailInMemory(response)
            CacheManager.shared.cacheMovieDetail(response, forId: id)
            return response
        } catch {
            // Fallback to UserDefaults if network request fails and not in memory
            if let cachedMovieDetail = CacheManager.shared.getCachedMovieDetail(forId: id) {
                CacheManager.shared.cacheMovieDetailInMemory(cachedMovieDetail) // Optionally cache in memory now
                return cachedMovieDetail
            } else {
                // If no cached movie detail available, rethrow the error
                throw error
            }
        }
    }

    func fetchMovieCredits(id: Int) async throws -> [CastMember] {
        let response: CreditsResponse = try await networkService.request(endpoint: MovieEndpoint.credits(id: id))
        return Array(response.cast.prefix(10)) // Return only the first 10 cast members
    }
}


