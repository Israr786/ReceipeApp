//
//  ReceipeAppUITests.swift
//  ReceipeAppUITests
//
//  Created by Israrul on 12/2/24.
//

import XCTest

class RecipeAppUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testRecipeListLoadsSuccessfully() throws {
        let recipesNavigationBar = app.navigationBars["Recipes"]
        XCTAssertTrue(recipesNavigationBar.exists, "The Recipes navigation bar should be visible.")

        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "The recipe list table view should be visible.")

        // Wait for data to load
        let firstCell = tableView.cells.firstMatch
        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The first recipe cell should be visible after loading.")
    }

    func testEmptyStateDisplaysCorrectly() throws {
        app.launchArguments.append("-EmptyState")
        app.launch()

        let emptyStateText = app.staticTexts["No recipes available."]
        XCTAssertTrue(emptyStateText.exists, "The empty state message should be displayed.")
    }

    func testErrorStateDisplaysCorrectly() throws {
        app.launchArguments.append("-ErrorState")
        app.launch()

        let errorText = app.staticTexts["Failed to parse recipes data."]
        XCTAssertTrue(errorText.exists, "The error message should be displayed.")

        let retryButton = app.buttons["Retry"]
        XCTAssertTrue(retryButton.exists, "The Retry button should be visible.")
        retryButton.tap()

        // Check if loading resumes
        let progressIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(progressIndicator.exists, "The loading indicator should be visible after tapping Retry.")
    }
}
