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
    func fetchRecipes(from url: String) async throws -> [Recipe]
    func getDefaultUrl() -> String
    func getMalformedUrl() -> String
    func getEmptyUrl() -> String
}

class RecipeService: RecipeServiceProtocol {
    private let service = Service<RecipeListResponse>()
    
    func fetchRecipes(from url: String = "") async throws -> [Recipe] {
        let endpoint = url.isEmpty ? EndPoints.defaultEndpoint.rawValue : url
        
        do {
            let response = try await service.fetchData(from: endpoint)
            
            guard !response.recipes.isEmpty else {
                throw NetworkError.emptyResponse
            }
            
            return response.recipes
        } catch NetworkError.dataParsingFailed {
            throw RecipeServiceError.malformedData
        } catch NetworkError.emptyResponse {
            throw RecipeServiceError.emptyData
        } catch {
            throw RecipeServiceError.unknownError
        }
    }
    
    func getDefaultUrl() -> String {
        return EndPoints.defaultEndpoint.rawValue
    }

    func getMalformedUrl() -> String {
        return EndPoints.malformedUrl.rawValue
    }

    func getEmptyUrl() -> String {
        return EndPoints.emptyUrl.rawValue
    }
}
