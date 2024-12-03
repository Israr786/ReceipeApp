//
//  GenericJsonDecoder.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import Foundation

protocol GenericJsonDecoder {
    associatedtype DataModel: Decodable
    func decode(input: Data) throws -> DataModel
}

extension GenericJsonDecoder {
    func decode(input: Data) throws -> DataModel {
        return try JSONDecoder().decode(DataModel.self, from: input)
    }
}
