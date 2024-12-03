//
//  RecipeCoordinator.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//


import SwiftUI

class RecipeCoordinator: ObservableObject {
    @Published var selectedRecipe: Recipe?
    @Published var showDetailView: Bool = false

    func navigateToDetail(for recipe: Recipe) {
        selectedRecipe = recipe
        showDetailView = true
    }

    func dismissDetailView() {
        showDetailView = false
        selectedRecipe = nil
    }
}
