//
//  RecipeDetailView.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    let recipe: Recipe

    @State private var showWebLink: Bool = false
    @State private var showYouTubePlayer: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let photoUrl = recipe.photoUrlLarge {
                    AsyncImageView(url: photoUrl, placeholder: {
                        AnyView(ProgressView())
                    })
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)

                Text(recipe.cuisine)
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)

                VStack(alignment: .leading, spacing: 16) {
                    if let sourceUrl = recipe.sourceUrl {
                        Button(action: {
                            showWebLink.toggle()
                        }) {
                            Label("View Recipe Source", systemImage: "link")
                                .font(.headline)
                        }
                        .sheet(isPresented: $showWebLink) {
                            WebView(url: sourceUrl)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }

                    if let youtubeUrl = recipe.youtubeUrl {
                        Button(action: {
                            showYouTubePlayer.toggle()
                        }) {
                            Label("Watch on YouTube", systemImage: "play.rectangle")
                                .font(.headline)
                        }
                        .sheet(isPresented: $showYouTubePlayer) {
                            YouTubePlayerView(youtubeUrl: youtubeUrl)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                }
                .padding(.vertical, 16)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}

struct YouTubePlayerView: View {
    let youtubeUrl: URL

    var body: some View {
        WebView(url: youtubeUrl)
            .cornerRadius(8)
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard (error as NSError).code != NSURLErrorCancelled else {
            return
        }
        print("Navigation failed with error: \(error)")
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
