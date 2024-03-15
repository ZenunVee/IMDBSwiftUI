//
//  RatingProgressBar.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import SwiftUI

// MARK: RatingProgressBar
struct RatingProgressBar: View {
    let percentage: Double

    var body: some View {
            ZStack {
                Circle()
                    .stroke(Color.black, lineWidth: 3)
                    .fill(.black)
                    .frame(width: 40, height: 40)
                Circle()
                    .trim(from: 0, to: CGFloat(min(percentage / 100, 1)))
                    .stroke(progressBarColor(for: percentage), lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(-90))
                Text("\(Int(percentage))%")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }

    private func progressBarColor(for percentage: Double) -> Color {
        switch percentage {
        case 0..<30:
            return .red
        case 30..<70:
            return .yellow
        default:
            return .green
        }
    }
}
