//
//  MovieDetailView.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import SwiftUI

// MARK: MovieDetailView
struct MovieDetailView: View {
    let movieId: Int
    @StateObject var viewModel = MovieDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showErrorAlert = false

    var body: some View {
        GeometryReader { proxy in

            ScrollView {
                    ZStack {

                        // Background image
                        if let posterPath = viewModel.movieDetail?.posterURL {
                            AsyncImage(url: posterPath) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .opacity(0.5) // Reduced opacity for background effect
                                        .blur(radius: 10)
                                        .edgesIgnoringSafeArea(.all)
                                        .frame(width: proxy.size.width, height: proxy.size.height)
                                }
                            }
                            .padding(.top, 48)
                        }

                        VStack {
                            // Display the movie's backdrop or poster as a large header image
                            if let backdropURL = viewModel.movieDetail?.backdropURL {
                                AsyncImage(url: backdropURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width - 40)
                                            .cornerRadius(20)
                                            .clipped()
                                    case .failure:
                                        Image("imdb")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                                            .cornerRadius(20)
                                            .clipped()
                                    default:
                                        EmptyView()
                                    }
                                }
                                .padding([.leading, .trailing], 20) 
                            } else if !viewModel.isLoading {
                                // Fallback to an IMDB placeholder
                                Image("imdb")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                                    .cornerRadius(20)
                                    .clipped()
                                    .padding([.leading, .trailing], 20)
                            }

                            // Movie title
                            Text(viewModel.movieDetail?.titleWithYear ?? "Loading...")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .lineLimit(3)
                                .padding(.top)
                                .padding([.leading, .trailing])
                                .multilineTextAlignment(.center)

                            if let tagline = viewModel.movieDetail?.tagline, !tagline.isEmpty {
                                Text(tagline)
                                    .italic()
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                            }

                            // Rating and genres in the same row
                            HStack {
                                // Display the movie's rating as a progress bar
                                if let voteAverage = viewModel.movieDetail?.voteAverage {
                                    RatingProgressBar(percentage: voteAverage * 10)
                                        .frame(height: 20)
                                }

                                Spacer()

                                if let releaseDate = viewModel.movieDetail?.releaseDate, let genres = viewModel.movieDetail?.genres.map({ $0.name }).joined(separator: ", "), let runtime = viewModel.movieDetail?.runtime {
                                    Text("\(releaseDate) • \(genres) • \(runtime.formattedRuntime)")
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding([.leading, .trailing, .top], 16)

                            // Movie overview
                            if let overview = viewModel.movieDetail?.overview {
                                Text(overview)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .padding()
                            }
                            if !viewModel.castMembers.isEmpty {
                            Text("Cast")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading)
                                .padding(.top, 20)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)

                            // Horizontal ScrollView for Cast Members
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.castMembers) { castMember in
                                        VStack {
                                            if let url = castMember.profileURL {
                                                AsyncImage(url: url) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Color.gray.frame(width: 100, height: 150)
                                                }
                                                .frame(width: 100, height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                                Text(castMember.name)
                                                    .font(.caption)
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(1)
                                                    .frame(width: 100) // Ensure the text aligns with the image width
                                            }

                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        }
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Oops!"),
                    message: Text("Failed to get this movie's awesome details. Please try again in a bit!"),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss() // Dismiss and return to MovieGridView
                    }
                )
            }
            .onAppear {
                Task {
                    do {
                        await viewModel.fetchMovieDetails(id: movieId)
                        await viewModel.fetchMovieCredits(id: movieId)
                    } catch {
                        showErrorAlert = true
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

