//
//  RecipeService.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.


import Foundation

enum RecipeServiceError: Error {
    case malformedData
    case emptyData
    case unknownError
}

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    private let networkService: Service<RecipeListResponse>

    init(networkService: Service<RecipeListResponse> = Service()) {
        self.networkService = networkService
    }

    func fetchRecipes() async throws -> [Recipe] {
        let response = try await networkService.fetchData(from: EndPoints.defaultEndpoint.rawValue)
        return response.recipes
    }
}
