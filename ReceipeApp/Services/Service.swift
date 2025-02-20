//
//  Service.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//
import Foundation

protocol ServiceProtocol {
    associatedtype DataModel: Decodable
    func fetchData(from url: String) async throws -> DataModel
}

class Service<Model: Decodable>: ServiceProtocol, GenericJsonDecoder {
    typealias DataModel = Model

    func fetchData(from url: String) async throws -> Model {
        guard let url = URL(string: url) else {
            throw NetworkError.malformedUrl
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard !data.isEmpty else {
            throw NetworkError.emptyResponse
        }

        do {
            return try decode(input: data)
        } catch {
            throw NetworkError.dataParsingFailed
        }
    }
}
