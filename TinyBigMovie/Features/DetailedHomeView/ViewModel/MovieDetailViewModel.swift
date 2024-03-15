//
//  MovieDetailViewModel.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation
import Combine

// MARK: MovieDetailViewModel
@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var castMembers: [CastMember] = []
    
    private var movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }

    func fetchMovieDetails(id: Int) async {
        isLoading = true
        do {
            movieDetail = try await movieService.fetchMovieDetails(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func fetchMovieCredits(id: Int) async {
        do {
            let castMembers = try await movieService.fetchMovieCredits(id: id)
            DispatchQueue.main.async {
                self.castMembers = castMembers
            }
        } catch {
            print("Error fetching movie credits: \(error)")
        }
    }
}

