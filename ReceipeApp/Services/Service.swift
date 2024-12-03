//
//  Service.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//
import Foundation

class Service<Model: Decodable>: ServiceProtocol, GenericJsonDecoder {
    typealias DataModel = Model

    func fetchData(from url: String) async throws -> Model {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
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

    func fetchImage(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.malformedUrl
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard !data.isEmpty else {
            throw NetworkError.emptyResponse
        }

        return data
    }
}
