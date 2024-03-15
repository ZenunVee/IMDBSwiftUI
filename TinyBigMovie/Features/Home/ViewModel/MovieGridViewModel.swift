//
//  MovieGridViewModel.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: MovieGridViewModel
@MainActor
class MovieGridViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var isLoading = false
    private var currentPage = 1
    var canLoadMorePages = true

    func fetchPopularMovies() async {
        guard !isLoading && canLoadMorePages else { return }

        isLoading = true

        do {
            let fetchedMovies = try await MovieService().fetchPopularMovies(page: currentPage)
            if fetchedMovies.isEmpty {
                canLoadMorePages = false
            }
            movies += fetchedMovies
            currentPage += 1
        } catch {
            print(error)
        }

        isLoading = false
    }
}

