//
//  ImageLoader.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation
import UIKit

// MARK: ImageLoader
class ImageLoader: ObservableObject {
    private var cache = NSCache<NSURL, UIImage>()

    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: url as NSURL)
            return image
        } catch {
            print(error)
            return nil
        }
    }
}
