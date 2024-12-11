//
//  ImageChace.swift
//  raven
//
//  Created by Angel Olvera on 10/12/24.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()

    private var cache = NSCache<NSURL, UIImage>()

    private init() {}

    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

struct AsyncImageView: View {
    @State private var uiImage: UIImage?
    let url: URL

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .frame(width: 75, height: 75)
        .clipped()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            self.uiImage = cachedImage
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }

            ImageCache.shared.saveImage(image, for: url)
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
        task.resume()
    }
}
