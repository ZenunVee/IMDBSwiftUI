//
//  CachedAsyncImage.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation
import SwiftUI

// MARK: CachedAsyncImage
struct CachedAsyncImage: View {
    let url: URL?
    @StateObject private var loader = ImageLoader()
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else if let url = url {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(gradient: Gradient(colors: [.gray, .secondary]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 150, height: 225)
                    .onAppear {
                        Task {
                            self.image = await loader.loadImage(from: url)
                        }
                    }
            }
        }
    }
}


