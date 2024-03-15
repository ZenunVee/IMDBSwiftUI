//
//  MovieGridItemView.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import SwiftUI

// MARK: MovieGridItemView
struct MovieGridItemView: View {
    let movie: Movie

    var body: some View {

        VStack {
            ZStack {
                CachedAsyncImage(url: movie.posterURL)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 225)
                    .cornerRadius(8)
                    .shadow(radius: 10)


                RatingProgressBar(percentage: movie.voteAverage * 10)
                    .padding(.trailing, 92)
                    .padding(.top, 225)

            }
            .frame(height: 225)

            Text(movie.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .lineLimit(1)
                .padding([.top, .horizontal])
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)

        }
        .frame(width: 150)
        .background(.background)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.bottom, 10)
    }
}



