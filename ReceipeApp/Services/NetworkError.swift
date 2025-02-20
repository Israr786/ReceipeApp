//
//  NetworkError.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import Foundation

enum NetworkError: Error {
    case malformedUrl
    case emptyResponse
    case dataParsingFailed
    case unknownError(Error)
}
