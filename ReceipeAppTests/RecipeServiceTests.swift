//
//  RecipeServiceTests.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import XCTest
@testable import ReceipeApp

class RecipeListViewModelTests: XCTestCase {
    func testFetchRecipes_Success() async {
        let mockService = MockRecipeService(mockRecipes: [
            Recipe(id: "1", name: "Pasta", cuisine: "Italian", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ])
        let viewModel = RecipeListViewModel(recipeService: mockService)

        await viewModel.fetchRecipes()

        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.state, .loaded)
    }

    func testFetchRecipes_Empty() async {
        let mockService = MockRecipeService(mockRecipes: [])
        let viewModel = RecipeListViewModel(recipeService: mockService)

        await viewModel.fetchRecipes()

        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.state, .empty)
    }

    func testFetchRecipes_Error() async {
        let mockService = MockRecipeService(mockError: NetworkError.dataParsingFailed)
        let viewModel = RecipeListViewModel(recipeService: mockService)

        await viewModel.fetchRecipes()

        XCTAssertEqual(viewModel.recipes.count, 0)
        if case .error(let errorMessage) = viewModel.state {
            XCTAssertEqual(errorMessage, "Failed to parse recipes data.")
        } else {
            XCTFail("Expected errXCTAssertEqualor state but got \(viewModel.state)")
        }
    }
}

class MockRecipeService: RecipeServiceProtocol {
    private let mockRecipes: [Recipe]?
    private let mockError: Error?

    init(mockRecipes: [Recipe]? = nil, mockError: Error? = nil) {
        self.mockRecipes = mockRecipes
        self.mockError = mockError
    }

    func fetchRecipes() async throws -> [Recipe] {
        if let error = mockError {
            throw error
        }
        return mockRecipes ?? []
    }
}
