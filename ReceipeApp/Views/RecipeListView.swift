//
//  RecipeListView.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var viewModel: RecipeListViewModel

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle:
                    Text("Welcome! Tap to load recipes.")
                        .multilineTextAlignment(.center)
                        .padding()

                case .loading:
                    ProgressView("Loading Recipes...")

                case .loaded:
                    List(viewModel.recipes) { recipe in
                        NavigationLink(
                            destination: RecipeDetailView(recipe: recipe)
                        ) {
                            RecipeRow(recipe: recipe)
                        }
                    }

                case .empty:
                    EmptyStateView(message: "No recipes available.")

                case .error(let message):
                    ErrorStateView(message: message) {
                        Task {
                            await viewModel.fetchRecipes()
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                if viewModel.state == .idle {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }
        }
    }
}
