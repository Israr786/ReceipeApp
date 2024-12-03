//
//  RecipeApp.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//


import SwiftUI

@main
struct RecipeApp: App {
    @StateObject private var recipeListViewModel = RecipeListViewModel()

    var body: some Scene {
        WindowGroup {
            RecipeListView()
                .environmentObject(recipeListViewModel)
        }
    }
}
