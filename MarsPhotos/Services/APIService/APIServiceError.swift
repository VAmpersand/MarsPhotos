//
//  APIServiceError.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import Foundation

enum APIServiceError: Error {
    case networkError(description: String)
    case decodeError(description: String)
}
