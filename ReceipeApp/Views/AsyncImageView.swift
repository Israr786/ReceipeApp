//
//  AsyncImageView.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.


import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let placeholder: () -> AnyView

    @State private var imageData: Data?

    var body: some View {
        if let imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            placeholder()
                .onAppear { loadImage() }
        }
    }

    private func loadImage() {
        guard let url else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request) {
            imageData = cachedResponse.data
            return
        }

        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                imageData = data
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedResponse, for: request)
                }
            } catch {
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
}
