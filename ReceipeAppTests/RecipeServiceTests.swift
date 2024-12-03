//
//  RecipeServiceTests.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import XCTest
@testable import ReceipeApp

final class RecipeServiceTests: XCTestCase {
    var recipeService: RecipeServiceProtocol!

    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
    }

    override func tearDown() {
        recipeService = nil
        super.tearDown()
    }

    func testFetchRecipesSuccess() async throws {
        let url = recipeService.getDefaultUrl()

        do {
            let recipes = try await recipeService.fetchRecipes(from: url)

            XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty for a valid response.")
            XCTAssertEqual(recipes[0].name, "Apam Balik", "The first recipe should match the expected data.")
        } catch {
            XCTFail("Fetching recipes failed with error: \(error)")
        }
    }

    func testFetchRecipesEmptyResponse() async {

        let url = recipeService.getEmptyUrl()

        do {
            let recipes = try await recipeService.fetchRecipes(from: url)
            XCTAssert(recipes.isEmpty)
        } catch RecipeServiceError.emptyData {
            XCTAssertTrue(true, "Correctly caught empty data error.")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchRecipesMalformedResponse() async {
        let url = recipeService.getMalformedUrl()

        do {
            let recipes = try await recipeService.fetchRecipes(from: url)
            XCTFail("Expected a malformed data error, but got \(recipes.count) recipes instead.")
        } catch RecipeServiceError.malformedData {
            XCTAssertTrue(true, "Correctly caught malformed data error.")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
