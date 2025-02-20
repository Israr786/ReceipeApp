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

    func fetchRecipes() async {
        await MainActor.run {
            state = .loading
        }

        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            await MainActor.run {
                if fetchedRecipes.isEmpty {
                    state = .empty
                } else {
                    recipes = fetchedRecipes
                    state = .loaded
                }
            }
        } catch NetworkError.dataParsingFailed {
            await MainActor.run {
                state = .error("Failed to parse recipes data.")
            }
        } catch NetworkError.emptyResponse {
            await MainActor.run {
                state = .error("No recipes were found.")
            }
        } catch {
            await MainActor.run {
                state = .error("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }
}
