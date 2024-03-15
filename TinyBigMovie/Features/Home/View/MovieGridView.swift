//
//  MovieGridView.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import SwiftUI

// MARK: MovieGridView
struct MovieGridView: View {
    @StateObject var viewModel = MovieGridViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieGridItemView(movie: movie)
                        }
                    }
                    if viewModel.canLoadMorePages {
                        Rectangle().foregroundColor(.clear)
                            .onAppear {
                                Task {
                                    await viewModel.fetchPopularMovies()
                                }
                            }
                    }
                }
            }
            .background(Color(hex: "f3ce13"))
            .navigationTitle("Popular Movies")
            .onAppear {
                Task {
                    await viewModel.fetchPopularMovies()
                }
            }
        }
    }
}

