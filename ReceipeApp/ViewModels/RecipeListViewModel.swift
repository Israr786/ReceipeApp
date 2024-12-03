//
//  RecipeListViewModel.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import Foundation
import Combine
import SwiftUI

enum RecipeListState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var state: RecipeListState = .idle

    private let recipeService: RecipeServiceProtocol

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
            self.recipeService = recipeService
        }

    func fetchRecipes(from url: String = "") async {
        await MainActor.run {
            state = .loading
            recipes = []
        }

        do {
            let fetchedRecipes = try await recipeService.fetchRecipes(from: url)
            await MainActor.run {
                if fetchedRecipes.isEmpty {
                    state = .empty
                } else {
                    recipes = fetchedRecipes
                    state = .loaded
                }
            }
        } catch {
            await MainActor.run {
                if let decodingError = error as? DecodingError {
                    state = .error("Failed to parse recipes data.")
                    print(decodingError)
                } else {
                    state = .error("Failed to load recipes: \(error.localizedDescription)")
                }
            }
        }
    }
}
